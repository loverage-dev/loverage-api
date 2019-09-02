defmodule LoverageWeb.CommentView do
  @moduledoc """
    The Comment View
    ・コメント情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.CommentView

  def render("created.json", %{comment: comment}) do
    %{
      post_id: comment.post_id,
      message: "コメントの投稿が完了しました。"
    }
  end

  def render("index.json", %{comments: comments}) do
    %{contents: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{content: render_one(comment, CommentView, "comment.json")}
  end

  def render("updated.json",%{comment: comment}) do
    %{
      post_id: comment.post_id,
      origin_id: comment.id,
      updated_at: comment.updated_at,
      message: "コメントを更新しました。"
    }
  end
  
  def render("delete.json", %{comment: comment}) do
    %{
      message: "コメントを削除しました。"
    }
  end

  def render("comment.json", %{comment: comment}) do
    %{
      post_id: comment.post_id,
      origin_id: comment.id,
      content: comment.content,
      icon_id: comment.icon_id,
      selected_opt: comment.selected_opt,
      user_age: comment.age,
      user_sex: comment.sex,
      created_at: comment.inserted_at
    }
  end
end
