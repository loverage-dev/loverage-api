defmodule LoverageWeb.CommonController do
  @moduledoc """
    The Common Controller
    ・投稿記事のダイジェスト情報を作成するためのAPIを定義
  """
  use LoverageWeb, :controller

  alias Loverage.Discussion
  alias Loverage.Pickup
  action_fallback(LoverageWeb.FallbackController)

  # @featureds_limit "6"
  # @ranking_limit "6"
  # @hot_topics_limit "3"
  # @latest_limit "3"
  # @editors_pick_limit "4"
  # @topics_limit "11"

  # @top_featured_limit "4"
  @featured_limit "5"
  @ranking_limit "3"
  @hot_topics_limit "3"
  @latest_limit "3"
  @editors_topick_limit "4"
  # @others1_topics_limit "4"
  # @others2_topics_limit "4"

  # @top_featured_limit 4
  @featured_limit 5
  # @ranking_limit 3
  # @hot_topics_limit 3
  # @latest_limit 3
  # @editors_topick_limit 4
  @others1_topics_limit 4
  @others2_topics_limit 4

  def indexies(conn, common_params) do
    # featuredの取得
    top_featureds = Pickup.list_featureds(%{"limit" => 4})

    # 男性向けFuturedを取得
    %{post_id: id} = Pickup.fetch_big_futured_topic_for("m")
    big_futured_for_m = Discussion.get_post(id)

    # 女性向けFuturedを取得
    %{post_id: id} = Pickup.fetch_big_futured_topic_for("f")
    big_futured_for_f = Discussion.get_post(id)

    # 閲覧数ランキング上位を取得
    rankings_view = Discussion.list_posts_ranking_view(%{"limit" => 3})

    # 回答数数ランキング上位を取得
    # rankings_vote = Discussion.list_posts_ranking_vote(%{ "limit" => @ranking_limit })

    # 最新記事
    latests = Discussion.list_posts_latest(%{"limit" => 3})

    # ------------- 以降、既に取得済みの記事は除いて取得する -------------------
    # idを集約
    all_posts =
      top_featureds ++ [big_futured_for_m] ++ [big_futured_for_f] ++ rankings_view ++ latests

    # featuredの取得
    featureds_exclude = aggrigate_exclude_ids(all_posts, [0])
    # featureds =
    #   Pickup.list_featureds(%{"limit" => @featured_limit })
    featureds =
      Pickup.list_featureds(%{"exclude" => featureds_exclude})
      |> Enum.slice(0, @featured_limit)

    # HotTopicsの取得
    hot_topics_exclude = aggrigate_exclude_ids(featureds, featureds_exclude)
    hot_topics =
      Pickup.list_hottopics(%{ "limit" => @hot_topics_limit })
    # hot_topics =
    #   Pickup.list_hottopics(%{ "limit" => 10, "exclude" => hot_topics_exclude })
    #   |> Enum.slice(0, @hot_topics_limit)

    # Editor's Pickの取得

    editors_picks_exclude = aggrigate_exclude_ids(hot_topics, hot_topics_exclude)
    editors_picks =
      Pickup.list_recommendations(%{ "limit" => @editors_pick_limit })
    # editors_picks =
    #   Pickup.list_recommendations(%{ "limit" => 10, "exclude" => editors_picks_exclude })
    #   |> Enum.slice(0, @editors_pick_limit)

    # Topicsの取得
    topics_exclude = aggrigate_exclude_ids(editors_picks, editors_picks_exclude)
    topics = Discussion.list_posts(%{ "limit" => 20, "exclude" => topics_exclude })
    others_1 = Enum.slice(topics, 0, @others1_topics_limit)
    others_2 = Enum.slice(topics, @others1_topics_limit, @others2_topics_limit)

    # 概要の生成
    over_view = %{
      big_futured_for_m: big_futured_for_m,
      big_futured_for_f: big_futured_for_f,
      rankings_view: rankings_view,
      # rankings_vote: rankings_vote,
      latests: latests,
      hot_topics: hot_topics,
      editors_picks: editors_picks,
      top_featureds: top_featureds,
      featureds: featureds,
      others_1: others_1,
      others_2: others_2
    }

    # JSONの描画
    render(conn, "indexies.json", over_view: over_view)
  end

  def aggrigate_exclude_ids(post_list, exclude_id_list) do
    tmp_list = [0]
    new_exclude_id_list = for n <- post_list, into: tmp_list, do: n.id
    all = new_exclude_id_list ++ exclude_id_list
    uniq_all = Enum.uniq(all)
    uniq_all
  end

end
