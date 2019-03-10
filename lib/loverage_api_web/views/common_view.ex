defmodule LoverageWeb.CommonView do
  @moduledoc """
    The Common View
    ・投稿記事のダイジェスト情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.CommonView
  alias LoverageWeb.FeaturedView
  alias LoverageWeb.PostView
  alias LoverageWeb.HotTopicView
  alias LoverageWeb.RecommendationView

  def render("indexies.json", %{over_view: over_view}) do
    %{
      big_futured_for_m: render(PostView, "post_overview.json", post: over_view.big_futured_for_m),
      big_futured_for_f: render(PostView, "post_overview.json", post: over_view.big_futured_for_f),
      rankings_view: render(PostView, "index.json", posts: over_view.rankings_view),
      latest: render(PostView, "index.json", posts: over_view.latests),
      hot_topic: render(HotTopicView, "index.json", hot_topics: over_view.hot_topics),
      editors_picks: render(RecommendationView, "index.json", recommendations: over_view.editors_picks),
      top_featured: render(FeaturedView, "index.json", featureds: over_view.top_featureds),
      featured: render(FeaturedView, "index.json", featureds: over_view.featureds),
      others_1: render(PostView, "index.json", posts: over_view.others_1),
      others_2: render(PostView, "index.json", posts: over_view.others_2)
    }
  end
end
