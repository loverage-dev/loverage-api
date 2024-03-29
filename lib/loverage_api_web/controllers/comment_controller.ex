defmodule LoverageWeb.CommentController do
  @moduledoc """
    The Comment Controller
    ・コメント情報にアクセスするためのAPIを定義
  """
  use LoverageWeb, :controller

  alias Loverage.Discussion
  alias Loverage.Discussion.Comment

  action_fallback LoverageWeb.FallbackController

  def index(conn,comments_params) do
    comments = Discussion.list_comments(comments_params)
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"id" => post_id, "comment" => comment_params}) do

    all_params = Map.put(comment_params, "post_id", post_id)

    with {:ok, %Comment{} = comment} <- Discussion.create_comment(all_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", comment_path(conn, :show, comment))
      |> render("created.json", comment: comment)
    end
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Discussion.get_comment!(id)
    with {:ok, %Comment{} = comment} <- Discussion.update_comment(comment, comment_params) do
      render(conn, "updated.json", comment: comment)
    end
  end

  def favorite(conn, %{"id" => id}) do
    Discussion.increment_comment_stars(id)
    comment = Discussion.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def unfavorite(conn, %{"id" => id}) do
    Discussion.decrement_comment_stars(id)
    comment = Discussion.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end
  
  def delete(conn, %{"id" => id}) do
    comment = Discussion.get_comment!(id)
    with {:ok, %Comment{}} <- Discussion.delete_comment(comment) do
      render(conn, "delete.json", comment: comment)
      #send_resp(conn, :no_content, "")
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Discussion.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end
end
