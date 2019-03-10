defmodule LoverageWeb.ReviewController do
  @moduledoc """
    The Review Controller
    ・投票情報にアクセスするためのAPIを定義
  """
  use LoverageWeb, :controller

  alias Loverage.Discussion
  alias Loverage.Discussion.Review

  action_fallback LoverageWeb.FallbackController

  def index(conn,reviews_params) do
    reviews = Discussion.list_reviews(reviews_params)
    render(conn, "index.json", reviews: reviews)
  end

  def create(conn, %{"id" => post_id, "vote" => review_params}) do

    all_params = Map.put(review_params, "post_id", post_id)
    with {:ok, %Review{} = review} <- Discussion.create_review(all_params) do
      Discussion.update_posts_updated_at(post_id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", review_path(conn, :show, review))
      |> render("created.json", review: review)
    end
  end

  def show(conn, %{"id" => id}) do
    review = Discussion.get_review!(id)
    render(conn, "show.json", review: review)
  end
end
