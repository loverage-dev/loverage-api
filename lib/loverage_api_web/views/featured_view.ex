defmodule LoverageWeb.FeaturedView do
  @moduledoc """
    The Common View
    ・Featured情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.FeaturedView
  import LoverageWeb.ViewHelpers

  def render("created.json", %{featured: featured}) do
    %{
      post_id: featured.post_id,
      message: "featuredへ登録しました。"
    }
  end

  def render("index.json", %{featureds: featureds}) do
    %{articles: render_many(featureds, FeaturedView, "post_overview.json")}
  end

  def render("show.json", %{featured: featured}) do
    %{article: render_one(featured, FeaturedView, "post_detail.json")}
  end

  def render("post_overview.json", %{featured: featured}) do
    %{
      id: featured.post_id,
      content: featured.posts.content |> auto_ellipsis,
      opt1: featured.posts.opt1,
      opt2: featured.posts.opt2,
      ref_count: featured.posts.ref_count,
      img_fmt: featured.posts.img_fmt,
      img_base64: featured.posts.img_base64,
      # category: featured.posts.category,
      tag_list: featured.posts.tag_list,
      votes_amount: featured.posts.reviews_amount,
      created_at: featured.posts.inserted_at,
      updated_at: featured.posts.updated_at,
      user_name: featured.posts.name,
      user_age: featured.posts.age,
      user_sex: featured.posts.sex,
      img_tag: featured.img_tag
    }
  end

  def render("post_detail.json", %{featured: featured}) do
    reviews = featured.posts.reviews

    %{
      post: %{
        id: featured.post_id,
        content: featured.posts.content,
        opt1: featured.posts.opt1,
        opt2: featured.posts.opt2,
        ref_count: featured.posts.ref_count,
        # TODO: IMAGEをひっぱってくるようにする。
        image_url: "sample",
        category: featured.posts.category,
        tag_list: featured.posts.tag_list,
        votes_amount: featured.posts.reviews_amount,
        created_at: featured.posts.inserted_at,
        updated_at: featured.posts.updated_at,
        img_tag: featured.posts.img_tag
      },
      user: %{
        name: featured.posts.name,
        age: featured.posts.age,
        sex: featured.posts.sex
      },
      votes: %{
        amount: featured.posts.reviews_amount,
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
