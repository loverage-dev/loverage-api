defmodule LoverageWeb.VisualView do
  @moduledoc """
    The Common View
    ・Featured情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.VisualView
  import LoverageWeb.ViewHelpers

  def render("created.json", %{visual: visual}) do
    %{
      post_id: visual.post_id,
      day_of_week_no: visual.day_of_week_no,
      type: visual.type,
      message: "visualへ登録しました。"
    }
  end
  
  def render("updated.json", %{visual: visual}) do
    %{
      post_id: visual.post_id,
      day_of_week_no: visual.day_of_week_no,
      type: visual.type,
      message: "visualを更新しました。"
    }
  end

  def render("index.json", %{visuals: visuals}) do
    %{articles: render_many(visuals, VisualView, "post_overview.json")}
  end

  def render("show.json", %{visual: visual}) do
    %{article: render_one(visual, VisualView, "post_detail.json")}
  end

   def render("delete.json", %{visual: visual}) do
    %{
      message: "visualから削除しました。"
    }
  end

  def render("post_overview.json", %{visual: visual}) do
    category_name = if visual.posts.categories != nil, do: visual.posts.categories.name
    %{
      visual_id: visual.id,
      visual_type: visual.type,
      visual_day_of_week_no: visual.day_of_week_no, 
      post_id: visual.post_id,
      origin_id: visual.id,
      content: visual.posts.content |> auto_ellipsis,
      opt1: visual.posts.opt1,
      opt2: visual.posts.opt2,
      ref_count: visual.posts.ref_count,
      img_fmt: visual.posts.img_fmt,
      img_base64: visual.posts.img_base64,
      # category: visual.posts.category,
      tag_list: visual.posts.tag_list,
      votes_amount: visual.posts.reviews_amount,
      created_at: visual.posts.inserted_at,
      updated_at: visual.posts.updated_at,
      user_name: visual.posts.name,
      user_age: visual.posts.age,
      user_sex: visual.posts.sex,
      img_tag: visual.posts.img_tag,
      category: category_name,
      category_id: visual.posts.category_id
    }
  end

  def render("post_detail.json", %{visual: visual}) do
    reviews = visual.posts.reviews
    category_name = if visual.posts.categories != nil, do: visual.posts.categories.name

    %{
      post: %{
        id: visual.post_id,
        content: visual.posts.content,
        opt1: visual.posts.opt1,
        opt2: visual.posts.opt2,
        ref_count: visual.posts.ref_count,
        # TODO: IMAGEをひっぱってくるようにする。
        image_url: "sample",
        category: category_name,
        tag_list: visual.posts.tag_list,
        votes_amount: visual.posts.reviews_amount,
        created_at: visual.posts.inserted_at,
        updated_at: visual.posts.updated_at,
        img_tag: visual.posts.img_tag,
        category_id: visual.posts.category_id
      },
      user: %{
        name: visual.posts.name,
        age: visual.posts.age,
        sex: visual.posts.sex
      },
      votes: %{
        amount: visual.posts.reviews_amount,
        opt1_selected: %{
          sex: %{
            votes_by_m:
              Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.sex == "m" end),
            votes_by_f:
              Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.sex == "f" end),
            votes_by_o: Enum.count(reviews, fn x -> x.selected_opt == "opt1" and x.sex == "o" end)
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
          }
        },
        opt2_selected: %{
          sex: %{
            votes_by_m:
              Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.sex == "m" end),
            votes_by_f:
              Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.sex == "f" end),
            votes_by_o: Enum.count(reviews, fn x -> x.selected_opt == "opt2" and x.sex == "o" end)
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
          }
        }
      }
    }
  end
end
