defmodule LoverageWeb.RecommendationView do
  @moduledoc """
    The Post View
    ・Editor's Pick情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.RecommendationView
  import LoverageWeb.ViewHelpers

  def render("created.json", %{recommendation: recommendation}) do
    %{
      post_id: recommendation.post_id,
      message: "Editor's Pickへ登録しました。"
    }
  end

  def render("index.json", %{recommendations: recommendations}) do
    %{articles: render_many(recommendations, RecommendationView, "post_overview.json")}
  end

  def render("show.json", %{recommendation: recommendation}) do
    %{article: render_one(recommendation, RecommendationView, "post_detail.json")}
  end

  def render("post_overview.json", %{recommendation: recommendation}) do
    %{
      id: recommendation.post_id,
      content: recommendation.posts.content |> auto_ellipsis,
      opt1: recommendation.posts.opt1,
      opt2: recommendation.posts.opt2,
      ref_count: recommendation.posts.ref_count,
      img_fmt: recommendation.posts.img_fmt,
      img_base64: recommendation.posts.img_base64,
      # category: recommendation.posts.category,
      tag_list: recommendation.posts.tag_list,
      votes_amount: recommendation.posts.reviews_amount,
      created_at: recommendation.posts.inserted_at,
      updated_at: recommendation.posts.updated_at,
      user_name: recommendation.posts.name,
      user_age: recommendation.posts.age,
      user_sex: recommendation.posts.sex,
      img_tag: recommendation.posts.img_tag
    }
  end

  def render("post_detail.json", %{recommendation: recommendation}) do
    reviews = recommendation.posts.reviews

    %{
      post: %{
        id: recommendation.post_id,
        content: recommendation.posts.content,
        opt1: recommendation.posts.opt1,
        opt2: recommendation.posts.opt2,
        ref_count: recommendation.posts.ref_count,
        # TODO: IMAGEをひっぱってくるようにする。
        image_url: "sample",
        category: recommendation.posts.category,
        tag_list: recommendation.posts.tag_list,
        votes_amount: recommendation.posts.reviews_amount,
        created_at: recommendation.posts.inserted_at,
        updated_at: recommendation.posts.updated_at,
        img_tag: recommendation.posts.img_tag
      },
      user: %{
        name: recommendation.posts.name,
        age: recommendation.posts.age,
        sex: recommendation.posts.sex
      },
      votes: %{
        amount: recommendation.posts.reviews_amount,
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
