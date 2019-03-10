defmodule LoverageWeb.PostController do
  @moduledoc """
    The Post Controller
    ・投稿記事情報にアクセスするためのAPIを定義
  """
  use LoverageWeb, :controller

  alias Loverage.Discussion
  alias Loverage.Discussion.Post

  action_fallback LoverageWeb.FallbackController

  def index(conn,posts_params) do
    posts = Discussion.list_posts(posts_params)
    render(conn, "index.json", posts: posts)
  end


  def ranking_view(conn, posts_params) do
    rankings_view = Discussion.list_posts_ranking_view(posts_params)
    render(conn, "index.json", posts: rankings_view)
  end

  def ranking_vote(conn, posts_params) do
    ranking_vote = Discussion.list_posts_ranking_vote(posts_params)
    render(conn, "index.json", posts: ranking_vote)
  end

  def index_latest(conn,posts_params) do
    posts = Discussion.list_posts_latest(posts_params)
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Discussion.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("created.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Discussion.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def delete(conn, %{"id" => id}) do
    post = Discussion.get_post!(id)
    with {:ok, %Post{}} <- Discussion.delete_post(post) do
      render(conn, "delete.json", post: post)
      #send_resp(conn, :no_content, "")
    end
  end
end
