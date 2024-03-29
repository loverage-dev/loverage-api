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

  def index_random(conn,posts_params) do
    posts = Discussion.list_posts_at_random(posts_params)
    render(conn, "index.json", posts: posts)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Discussion.get_post!(id)
    with {:ok, %Post{} = post} <- Discussion.update_post(post, post_params) do
      render(conn, "updated.json", post: post)
    end
  end

  def update_datetime(conn, %{"id" => id}) do
    with {:ok, %Post{} = post} <- Discussion.update_posts_updated_at(id) do
      render(conn, "up_to_pickup.json", post: post)
    end
  end

  def favorite(conn,%{"id" => id}) do
    post = Discussion.set_post_to_favorite(id)
    render(conn, "show.json", post: post)
  end

  def unfavorite(conn,%{"id" => id}) do
    post = Discussion.unset_post_to_favorite(id)
    render(conn, "show.json", post: post)
  end

  def set_eye_catching(conn,%{"post" => post_params}) do
    %{"id" => id, "tag" => tag} = post_params
    post = Discussion.get_post!(id)
    with {:ok, %Post{} = post} <- Discussion.update_post(post, %{"img_tag" => tag}) do
      render(conn, "show.json", post: post)
    end
  end

  def ranking_view(conn, posts_params) do
    rankings_view = Discussion.list_posts_ranking_view(posts_params)
    render(conn, "index.json", posts: rankings_view)
  end

  def ranking_favorite(conn, posts_params) do
    rankings_favorite = Discussion.list_posts_ranking_favorite(posts_params)
    render(conn, "index.json", posts: rankings_favorite)
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

  def show_no_count_ref(conn, %{"id" => id}) do
    post = Discussion.get_post_no_count_ref(id)
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
