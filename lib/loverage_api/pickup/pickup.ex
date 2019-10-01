defmodule Loverage.Pickup do
  @moduledoc """
  The Pickup context.
    ・HotTpicについてのDB処理
    ・Racommendation(Editor's Pick)についてのDB処理
    ・FeaturedについてのDB処理
  """

  import Ecto.Query, warn: false
  alias Loverage.Repo

  alias Loverage.Pickup.HotTopic
  alias Loverage.Discussion.Post
  alias Loverage.Pickup.Recommendation
  alias Loverage.Pickup.Featured

  @default_recommends_pagination_limit 6
  @default_hottopics_pagination_limit 6
  @default_featureds_pagination_limit 6

  @doc """
    HotTopicの一覧を返却する。【引数なし】
  """
  def list_hottopics do
    Repo.all(HotTopic)
  end
  @doc """
    HotTopicの一覧を返却する。【引数あり】
  """
  def list_hottopics(hottopics_params) do

    # 絞込条件
    limit = hottopics_params["limit"] || @default_hottopics_pagination_limit
    offset = hottopics_params["offset"] || 0

    # 検索
    (
      from h in HotTopic,
        limit: ^limit,
        offset: ^offset,
        join: p in Post, where: h.post_id == p.id,
        order_by: [desc: p.updated_at],
        left_join: posts in assoc(h, :posts),
        left_join: category in assoc(posts, :categories),
        preload: [posts: {posts, categories: category}]
    )
    |> filter_by_exclude(hottopics_params["exclude"])
    |> Repo.all()
  end

  @doc """
    指定されたIDを除外フィルタリング（指定なし）
  """
  def filter_by_exclude(query, nil) do
    query
  end

  @doc """
    指定されたIDを除外フィルタリング（指定あり）
  """
  def filter_by_exclude(query, exclude_list) do
    query |> where([p], not p.id in ^exclude_list)
  end

  @doc """
    HotTopicを1件取得する。
  """
  def get_hot_topic!(id) do
    (
      from h in HotTopic,
        where: h.id == ^id,
        join: p in Post, where: p.id == h.post_id,
        left_join: posts in assoc(h, :posts),
        left_join: reviews in assoc(posts, :reviews),
        left_join: category in assoc(posts, :categories),
        preload: [posts: {posts, reviews: reviews, categories: category}]
    )
    |> Repo.one()
  end

  @doc """
    HotTopicを作成する。
  """
  def create_hot_topic(attrs \\ %{}) do
    %HotTopic{}
    |> HotTopic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    HotTopicの更新日付を上書き更新する。
  """
  def override_hot_topic_updated_at(attrs \\ %{}) do
    Repo.get_by(HotTopic, post_id: attrs["post_id"])
    |> HotTopic.changeset_ignore_post_id_constraint(attrs)
    |> Repo.update(force: true)
  end

  @doc """
    HotTopicを更新する。
  """
  def update_hot_topic(%HotTopic{} = hot_topic, attrs) do
    hot_topic
    |> HotTopic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    HotTopicを削除する。
  """
  def delete_hot_topic(%HotTopic{} = hot_topic) do
    Repo.delete(hot_topic)
  end

  @doc """
    変更を追跡する。
  """
  def change_hot_topic(%HotTopic{} = hot_topic) do
    HotTopic.changeset(hot_topic, %{})
  end

  @doc """
    おすすめ一覧を取得する。【引数なし】
  """
  def list_recommendations do
    Repo.all(Recommendation)
  end

  @doc """
    おすすめ一覧を取得する。【引数あり】
  """
  def list_recommendations(recos_params) do
    # 絞込条件
    limit = recos_params["limit"] || @default_recommends_pagination_limit
    offset = recos_params["offset"] || 0

    # 検索
    (
      from r in Recommendation,
        limit: ^limit,
        offset: ^offset,
        join: p in Post, where: r.post_id == p.id,
        order_by: [desc: p.updated_at],
        left_join: posts in assoc(r, :posts),
        left_join: category in assoc(posts, :categories),
        preload: [posts: {posts, categories: category}]
    )
    |> filter_by_exclude(recos_params["exclude"])
    |> Repo.all()
  end

  @doc """
    おすすめ1件を取得する。
  """
  def get_recommendation!(id) do
    (
      from r in Recommendation,
        where: r.id == ^id,
        join: p in Post, where: p.id == r.post_id,
        left_join: posts in assoc(r, :posts),
        left_join: reviews in assoc(posts, :reviews),
        left_join: category in assoc(posts, :categories),
        preload: [posts: {posts, reviews: reviews, categories: category}]
    )
    |> Repo.one()
  end

  @doc """
    おすすめを作成する。
  """
  def create_recommendation(attrs \\ %{}) do
    %Recommendation{}
    |> Recommendation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    おすすめを更新する。
  """
  def update_recommendation(%Recommendation{} = recommendation, attrs) do
    recommendation
    |> Recommendation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    Featuredの更新日付を上書き更新する。
  """
  def override_recommendation_updated_at(attrs \\ %{}) do
    Repo.get_by(Recommendation, post_id: attrs["post_id"])
    |> Recommendation.changeset_ignore_post_id_constraint(attrs)
    |> Repo.update(force: true)
  end

  @doc """
    おすすめを削除する。
  """
  def delete_recommendation(%Recommendation{} = recommendation) do
    Repo.delete(recommendation)
  end

  @doc """
    変更を追跡する。
  """
  def change_recommendation(%Recommendation{} = recommendation) do
    Recommendation.changeset(recommendation, %{})
  end

  @doc """
    Featured一覧を取得する。【引数なし】
  """
  def list_featureds do
    Repo.all(Featured)
  end

  @doc """
    Featured一覧を取得する。【引数あり】
  """
  def list_featureds(featureds_params) do

    # 絞込条件
    limit = featureds_params["limit"] || @default_featureds_pagination_limit
    offset = featureds_params["offset"] || 0

    # 検索
    (
      from f in Featured,
        limit: ^limit,
        offset: ^offset,
        join: p in Post, where: f.post_id == p.id,
        order_by: [desc: p.updated_at],
        left_join: posts in assoc(f, :posts),
        left_join: category in assoc(posts, :categories),
        preload: [posts: {posts, categories: category}]
    )
    |> filter_by_exclude(featureds_params["exclude"])
    |> Repo.all()
  end

  @doc """
    Featuredを1件取得する。
  """
  def get_featured!(id) do
    (
      from f in Featured,
        where: f.id == ^id,
        join: p in Post, where: p.id == f.post_id,
        left_join: posts in assoc(f, :posts),
        left_join: reviews in assoc(posts, :reviews),
        left_join: category in assoc(posts, :categories),
        preload: [posts: {posts, reviews: reviews, categories: category}]
    )
    |> Repo.one()
  end

  def fetch_big_futured_topic_for(sex) do
    sql = "SELECT
              foo.post_id
            FROM
              (featureds inner join posts on featureds.post_id = posts.id) As foo
            where
              foo.sex = '" <> sex <> "'
            order by foo.reviews_amount desc
            limit 1
            "
    post_id_list = EctoUtil.query(Repo, sql)
    Enum.at(post_id_list, 0)
  end

  @doc """
    Featuredを作成する。
  """
  def create_featured(attrs \\ %{}) do
    %Featured{}
    |> Featured.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    Featuredを更新する。
  """
  def update_featured(%Featured{} = featured, attrs) do
    featured
    |> Featured.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    Featuredの更新日付を上書き更新する。
  """
  def override_featured_updated_at(attrs \\ %{}) do
    Repo.get_by(Featured, post_id: attrs["post_id"])
    |> Featured.changeset_ignore_post_id_constraint(attrs)
    |> Repo.update(force: true)
  end


  @doc """
    Featuredを削除する。
  """
  def delete_featured(%Featured{} = featured) do
    Repo.delete(featured)
  end

  @doc """
    変更を追跡する。
  """
  def change_featured(%Featured{} = featured) do
    Featured.changeset(featured, %{})
  end

  alias Loverage.Pickup.Visual

  @doc """
  Returns the list of visuals.
  """
  def list_visuals do
    Repo.all(Visual)
    |> Repo.preload(:posts)
  end

    @doc """
  Returns the list of visuals.
  """
  def list_visuals(visuals_params) do
    (
      from v in Visual,
      join: p in Post, where: v.post_id == p.id,
      left_join: posts in assoc(v, :posts),
      left_join: category in assoc(posts, :categories),
      preload: [posts: {posts, categories: category}]
    )
    |> filter_by_type(visuals_params["type"])
    |> filter_by_day_of_week_no(visuals_params["day_of_week_no"])
    |> Repo.all()
  end

  @doc """
    属性でフィルタリング（指定なし）
  """
  def filter_by_type(query, nil) do
    query
  end

  @doc """
    属性でフィルタリング（指定あり）
  """
  def filter_by_type(query, type) do
    query |> where([v], fragment("?", v.type) == ^type)
  end

  @doc """
    曜日でフィルタリング（指定なし）
  """
  def filter_by_day_of_week_no(query, nil) do
    query
  end

  @doc """
    曜日でフィルタリング（指定あり）
  """
  def filter_by_day_of_week_no(query, day_of_week_no) do
    d = String.to_integer(day_of_week_no)
    query |> where([v], fragment("?", v.day_of_week_no) == ^d)
  end

  @doc """
  Gets a single visual.
  """ 
  def get_visual!(id) do
    (
      from v in Visual,
        where: v.id == ^id,
        join: p in Post, where: p.id == v.post_id,
        left_join: posts in assoc(v, :posts),
        left_join: reviews in assoc(posts, :reviews),
        left_join: category in assoc(posts, :categories),
        preload: [posts: {posts, reviews: reviews, categories: category}]
    )
    |> Repo.one()
  end

  @doc """
  Creates a visual.
  """
  def create_visual(attrs \\ %{}) do
    %Visual{}
    |> Visual.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a visual.
  """
  def update_visual(%Visual{} = visual, attrs) do
    visual
    |> Visual.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Visual.
  """
  def delete_visual(%Visual{} = visual) do
    Repo.delete(visual)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking visual changes.
  """
  def change_visual(%Visual{} = visual) do
    Visual.changeset(visual, %{})
  end
end
