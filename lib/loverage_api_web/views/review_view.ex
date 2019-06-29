defmodule LoverageWeb.ReviewView do
  @moduledoc """
    The Review View
    ・投票情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.ReviewView

  def render("created.json", %{review: review}) do
    %{
      post_id: review.post_id,
      message: "回答が完了しました。"
    }
  end

  def render("index.json", %{reviews: reviews}) do
    %{reviews: render_many(reviews, ReviewView, "post.json")}
  end

  def render("show.json", %{review: review}) do
    %{review: render_one(review, ReviewView, "review.json")}
  end

  def render("review.json", %{review: review}) do
    %{
      post_id: review.id
    }
  end

end
