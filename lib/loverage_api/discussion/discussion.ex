defmodule Loverage.Discussion do


  @moduledoc """
    Discussionコンテキスト
    ・投稿記事についてのDB処理
    ・投票についてのDB処理
  """

  import Ecto.Query, warn: false
  alias Loverage.Repo
  alias Loverage.Discussion.Post
  alias Loverage.Discussion.Review
  alias Loverage.Discussion.Comment
  alias Loverage.Discussion.Category

  @default_posts_pagination_limit 30

  @doc """
    投稿記事を一括で取得する。【引数なし】
  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
    投稿記事を一括で取得する。【引数あり】
  """
  def list_posts(posts_params) do

    # 絞込条件
    limit = posts_params["limit"] || @default_posts_pagination_limit
    offset = posts_params["offset"] || 0

    # 検索
    (
      from p in Post,
      limit: ^limit,
      offset: ^offset,
      order_by: [desc: p.updated_at],
      preload: [:categories]
    )
    |> filter_by_exclude_id(posts_params["not"])
    |> filter_by_exclude_id_list(posts_params["exclude"])
    |> filter_by_age(posts_params["age"])
    |> filter_by_sex(posts_params["sex"])
    |> filter_by_target_word_in_content(posts_params["keyword"])
    |> filter_by_tags(posts_params["tag"])
    |> filter_by_category(posts_params["category"])
    |> Repo.all()

  end
  @doc """
    投稿記事を一括で取得する。【閲覧数が多いもの順】
  """
  def list_posts_ranking_view(posts_params) do

    # 絞込条件
    limit = posts_params["limit"]
    offset = posts_params["offset"] || 0

    # 検索
    from(p in Post, limit: ^limit, offset: ^offset, order_by: [desc: p.ref_count, desc: p.updated_at])
    |> Repo.all()
    |> Repo.preload(:categories)

  end

    @doc """
    投稿記事を一括で取得する。【お気に入りが多いもの順】
  """
  def list_posts_ranking_favorite(posts_params) do

    # 絞込条件
    limit = posts_params["limit"]
    offset = posts_params["offset"] || 0

    # 検索
    from(p in Post, limit: ^limit, offset: ^offset, order_by: [desc: p.favorite, desc: p.updated_at])
    |> Repo.all()
    |> Repo.preload(:categories)

  end

  @doc """
    投稿記事を一括で取得する。【投票数が多いもの順】
  """
  def list_posts_ranking_vote(posts_params) do

    # 絞込条件
    limit = posts_params["limit"]
    offset = posts_params["offset"] || 0

    # 検索
    from(p in Post, limit: ^limit, offset: ^offset, order_by: [desc: p.reviews_amount, desc: p.updated_at])
    |> Repo.all()
    |> Repo.preload(:categories)

  end
  @doc """
    投稿記事を一括で取得する。【登録日が新しいもの順】
  """
  def list_posts_latest(posts_params) do

    # 絞込条件
    limit = posts_params["limit"]
    offset = posts_params["offset"] || 0

    # 検索
    from(p in Post, limit: ^limit, offset: ^offset, order_by: [desc: p.inserted_at])
    |> Repo.all()
    |> Repo.preload(:categories)

  end

  @doc """
    指定されたIDリストを除外フィルタリング（指定なし）
  """
  def filter_by_exclude_id_list(query, nil) do
    query
  end

  @doc """
    指定されたIDリストを除外フィルタリング（指定あり）
  """
  def filter_by_exclude_id_list(query, exclude_list) do
    query |> where([p], not p.id in ^exclude_list)
  end

  @doc """
    指定されたIDを除外フィルタリング（指定なし）
  """
  def filter_by_exclude_id(query, nil) do
    query
  end

  @doc """
    指定されたIDを除外フィルタリング（指定あり）
  """
  def filter_by_exclude_id(query, id) do
    query |> where([p], not p.id in [^id])
  end

  @doc """
    タグ名でフィルタリング（指定なし）
  """
  def filter_by_tags(query, nil) do
    query
  end

  @doc """
    タグ名でフィルタリング（指定あり）
  """
  def filter_by_tags(query, tag) do
    query |> where([p], fragment("exists (select * from unnest(?) tag where tag = ?)", p.tag_list, ^tag))
  end

  @doc """
    投稿者の年齢でフィルタリング（指定なし）
  """
  def filter_by_age(query, nil) do
    query
  end

  @doc """
    投稿者の年齢でフィルタリング（指定あり）
  """
  def filter_by_age(query, age) do
    query |> where([p], fragment("?", p.age) == ^age)
  end

  @doc """
    投稿者の性別でフィルタリング（指定なし）
  """
  def filter_by_sex(query, nil) do
    query
  end

  @doc """
    投稿者の性別でフィルタリング（指定あり）
  """
  def filter_by_sex(query, sex) do
    query |> where([p], fragment("?", p.sex) == ^sex)
  end

  @doc """
    カテゴリ名でフィルタリング（指定なし）
  """
  def filter_by_category(query, nil) do
    query
  end

  @doc """
    カテゴリ名でフィルタリング（指定あり）
  """
  def filter_by_category(query, category) do

    query 
      |> join(:left, [p], c in assoc(p, :categories))
      |> where([_, c], c.name == ^category)
  end

  @doc """
    検索ワードでフィルタリング（指定なし）
  """
  def filter_by_target_word_in_content(query, nil) do
    query
  end
  @doc """
    検索ワードでフィルタリング（指定あり）
  """
  def filter_by_target_word_in_content(query, keyword) do
    query |> where([p], like(p.content, ^("%#{keyword}%")))
  end

  @doc """
    記事を1件取得する
  """
  def get_post!(id) do
    Repo.get!(Post, id)
    |> increment_ref_count
    |> Repo.preload([:reviews, :comments, :categories])
  end

   @doc """
    記事を1件取得する
  """
  def get_post(id) do
    Repo.get!(Post, id)
    |> Repo.preload([:reviews, :comments, :categories])
  end

  @doc """
    閲覧回数カウントアップ
  """
  def increment_ref_count(post) do
    from(p in Post, update: [inc: [ref_count: 1]], where: p.id == ^post.id)
    |> Repo.update_all([])
    post
  end

  @doc """
    記事を投稿する
  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    記事を更新する。
  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    記事を削除する。
  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
    Postの変更を追跡する。
  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end


  @doc """
    投票結果の一覧を返却する。【引数なし】
  """
  def list_reviews do
    Repo.all(Review)
  end

  @doc """
    投票結果の一覧を返却する。【引数あり】
  """
  def list_reviews(reviews_params) do

    # 絞り込み条件
    limit = reviews_params["limit"] || 60
    offset = reviews_params["offset"] || 0

    from(r in Review, limit: ^limit, offset: ^offset, order_by: r.updated_at)
    |> Repo.all()

  end

  @doc """
    投票結果を１件取得する
  """
  def get_review!(id), do: Repo.get!(Review, id)

  @doc """
    投票を作成する。
  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
    |> increment_reviews_amount
  end

  @doc """
    投票結果カウントアップ
  """
  def increment_reviews_amount(review_result) do
    with {:ok, %Review{} = review} <- review_result do
      from(p in Post, update: [inc: [reviews_amount: 1]], where: p.id == ^review.post_id)
      |> Repo.update_all([])
    end
    review_result
  end

  @doc """
    更新日付(updated_at)の更新
  """
  def update_posts_updated_at(id) do
    get_post(id)
    |> change_post()
    |> Repo.update(force: true)
  end

  @doc """
    投票を更新する。
  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    投票を削除する。
  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
    変更を追跡する。
  """
  def change_review(%Review{} = review) do
    Review.changeset(review, %{})
  end

  @doc """
    コメントの一覧を返却する。【引数なし】
  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
    コメントの一覧を返却する。【引数あり】
  """
  def list_comments(comments_params) do

    # 絞り込み条件
    limit = comments_params["limit"] || 60
    offset = comments_params["offset"] || 0

    from(c in Comment, limit: ^limit, offset: ^offset, order_by: c.updated_at)
    |> Repo.all()

  end

  @doc """
    コメントを1件取得する。
  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
    コメントを作成する。
  """
  def create_comment(attrs \\ %{}) do

    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    コメントを更新する。
  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    コメントを削除する。
  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
    コメントの変更を追跡する。
  ## Examples
  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end


  @doc """
    カテゴリーの一覧を返却する。
  """
  def list_categories do
    Repo.all(Category)
    |> Repo.preload([posts: :categories])
  end

    @doc """
    カテゴリーの一覧を返却する。
  """
  def namelist_categories do
    from(c in Category, order_by: c.id)
    |> Repo.all
  end

  @doc """
  カテゴリーを一見取得する。
  """
  def get_category!(id) do
    Repo.get!(Category, id)
    |> Repo.preload([posts: :categories])
  end

  @doc """
  カテゴリーを作成する。
  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  カテゴリーを更新する。
  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  カテゴリーを削除する。
  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  カテゴリの変更を追跡する。
  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end
end
