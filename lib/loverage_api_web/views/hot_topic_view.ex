defmodule LoverageWeb.HotTopicView do
  @moduledoc """
    The HotTopic View
    ・HotTopic情報のJSONデータを定義する
  """
  use LoverageWeb, :view
  alias LoverageWeb.HotTopicView
  import LoverageWeb.ViewHelpers

  def render("created.json", %{hot_topic: hottopic}) do
    %{
      post_id: hottopic.post_id,
      message: "HotTopicへ登録しました。"
    }
  end

  def render("delete.json", %{hot_topic: hottopic}) do
    %{
      message: "HotTopicから削除しました。"
    }
  end

  def render("index.json", %{hot_topics: hottopics}) do
    %{articles: render_many(hottopics, HotTopicView, "post_overview.json")}
  end

  def render("show.json", %{hot_topic: hottopic}) do
    %{article: render_one(hottopic, HotTopicView, "post_detail.json")}
  end

  def render("post_overview.json", %{hot_topic: hottopic}) do
    %{
      id: hottopic.post_id,
      origin_id: hottopic.id,
      content: hottopic.posts.content |> auto_ellipsis,
      opt1: hottopic.posts.opt1,
      opt2: hottopic.posts.opt2,
      ref_count: hottopic.posts.ref_count,
      img_fmt: hottopic.posts.img_fmt,
      img_base64: hottopic.posts.img_base64,
      # category: hottopic.posts.category,
      tag_list: hottopic.posts.tag_list,
      votes_amount: hottopic.posts.reviews_amount,
      created_at: hottopic.posts.inserted_at,
      updated_at: hottopic.posts.updated_at,
      user_name: hottopic.posts.name,
      user_age: hottopic.posts.age,
      user_sex: hottopic.posts.sex,
      img_tag: hottopic.posts.img_tag
    }
  end

  def render("post_detail.json", %{hot_topic: hottopic}) do
    reviews = hottopic.posts.reviews

    %{
      post: %{
        id: hottopic.post_id,
        content: hottopic.posts.content,
        opt1: hottopic.posts.opt1,
        opt2: hottopic.posts.opt2,
        ref_count: hottopic.posts.ref_count,
        # TODO: IMAGEをひっぱってくるようにする。
        image_url: "sample",
        category: hottopic.posts.category,
        tag_list: hottopic.posts.tag_list,
        votes_amount: hottopic.posts.reviews_amount,
        created_at: hottopic.posts.inserted_at,
        updated_at: hottopic.posts.updated_at,
        img_tag: hottopic.posts.img_tag
      },
      user: %{
        name: hottopic.posts.name,
        age: hottopic.posts.age,
        sex: hottopic.posts.sex
      },
      votes: %{
        amount: hottopic.posts.reviews_amount,
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
