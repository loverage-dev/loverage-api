defmodule LoverageWeb.PostView do
  @moduledoc """
    The Post View
    ・投稿記事情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.PostView
  alias LoverageWeb.CommentView
  import LoverageWeb.ViewHelpers

  def render("index.json", %{posts: posts}) do
    %{articles: render_many(posts, PostView, "post_overview.json")}
  end

  def render("show.json", %{post: post}) do
    %{article: render_one(post, PostView, "post_detail.json")}
  end

  def render("created.json", %{post: post}) do
    %{
      id: post.id,
      created_at: post.inserted_at,
      title: post.content |> auto_ellipsis,
      message: "投稿を登録しました。"
    }
  end

  def render("updated.json",%{post: post}) do
    %{
      id: post.id,
      updated_at: post.updated_at,
      title: post.content |> auto_ellipsis,
      message: "投稿を更新しました。"
    }
  end

    def render("up_to_pickup.json", %{post: post}) do
    %{
      id: post.id,
      updated_at: post.updated_at,
      message: "更新日時を最新化しました。"
    }
  end

  def render("delete.json", %{post: post}) do
    %{
      id: post.id,
      message: "投稿を削除しました。"
    }
  end

  def render("post_overview.json", %{post: post}) do
    category_name = if post.categories != nil, do: post.categories.name
    title = if post.title == nil or post.title == "", do: post.content |> sunitize_html |> auto_ellipsis, else: post.title

    %{
      id: post.id,
      content: title,
      opt1: post.opt1,
      opt2: post.opt2,
      ref_count: post.ref_count,
      favorite: post.favorite,
      img_fmt: post.img_fmt,
      img_base64: post.img_base64,
      category_id: post.category_id,
      category: category_name,
      tag_list: post.tag_list,
      votes_amount: post.reviews_amount,
      created_at: post.inserted_at,
      updated_at: post.updated_at,
      user_name: post.name,
      user_age: post.age,
      user_sex: post.sex,
      img_tag: post.img_tag
    }
  end

  def render("post_detail.json", %{post: post}) do
    reviews = post.reviews
    comments = post.comments
    category_name = if post.categories != nil, do: post.categories.name
    title = if post.title == nil or post.title == "", do: post.content |> sunitize_html |> auto_ellipsis, else: post.title
    %{
      post: %{
        id: post.id,
        title: title,
        content: post.content,
        opt1: post.opt1,
        opt2: post.opt2,
        ref_count: post.ref_count,
        favorite: post.favorite,
        img_fmt: post.img_fmt,
        img_base64: post.img_base64,
        category_id: post.category_id,
        category: category_name,
        tag_list: post.tag_list,
        votes_amount: post.reviews_amount,
        created_at: post.inserted_at,
        updated_at: post.updated_at,
        user_name: post.name,
        user_age: post.age,
        user_sex: post.sex,
        img_tag: post.img_tag
      },
      votes: %{
        # amount: post.reviews_amount,
        opt1_selected: %{
          sex: %{
            votes_by_m:
              Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.sex == "m" end),
            votes_by_f:
              Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.sex == "f" end),
            votes_by_o:
              Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.sex == "o" end)
          },
          age: %{
            e_10s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "e_10s" end),
            l_10s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "l_10s" end),
            e_20s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "e_20s" end),
            l_20s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "l_20s" end),
            e_30s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "e_30s" end),
            l_30s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "l_30s" end),
            e_40s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "e_40s" end),
            l_40s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "l_40s" end),
            e_50s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "e_50s" end),
            l_50s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "l_50s" end),
            e_60s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "e_60s" end),
            l_60s: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.age == "l_60s" end)
          },
          amount: Enum.count(reviews, fn x -> x.selected_opt == "opt1" end)
        },
        opt2_selected: %{
          sex: %{
            votes_by_m:
              Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.sex == "m" end),
            votes_by_f:
              Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.sex == "f" end),
            votes_by_o:
              Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.sex == "o" end)
          },
          age: %{
            e_10s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "e_10s" end),
            l_10s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "l_10s" end),
            e_20s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "e_20s" end),
            l_20s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "l_20s" end),
            e_30s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "e_30s" end),
            l_30s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "l_30s" end),
            e_40s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "e_40s" end),
            l_40s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "l_40s" end),
            e_50s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "e_50s" end),
            l_50s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "l_50s" end),
            e_60s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "e_60s" end),
            l_60s: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.age == "l_60s" end)
          },
          amount: Enum.count(reviews, fn x -> x.selected_opt == "opt2" end)
        }
      },
      comments: render(CommentView, "index.json", comments: comments)
    }
  end
end
