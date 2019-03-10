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
        order_by: [desc: h.updated_at],
        join: p in Post, where: h.post_id == p.id,
        left_join: posts in assoc(h, :posts),
        preload: [posts: posts]
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
        preload: [posts: {posts, reviews: reviews}]
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
        order_by: [desc: r.updated_at],
        join: p in Post, where: r.post_id == p.id,
        left_join: posts in assoc(r, :posts),
        preload: [posts: posts]
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
        preload: [posts: {posts, reviews: reviews}]
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
        order_by: [desc: f.updated_at],
        join: p in Post, where: f.post_id == p.id,
        left_join: posts in assoc(f, :posts),
        preload: [posts: posts]
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
        preload: [posts: {posts, reviews: reviews}]
    )
    |> Repo.one()
  end

  def fetch_big_futured_topic_for(sex) do
    sql = "select post_id from featureds
            inner join posts on featureds.post_id = posts.id
            where posts.sex = '" <> sex <> "' and
                  not exists(
                    select 1 from posts As tmp
                    where posts.sex = tmp.sex and
                    posts.reviews_amount < tmp.reviews_amount
                    )
            order by featureds.updated_at desc"
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
end
