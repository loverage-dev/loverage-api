defmodule LoverageWeb.HotTopicController do
  @moduledoc """
    The HotTopic Controller
    ・HotTopic情報にアクセスするためのAPIを定義
  """
  use LoverageWeb, :controller
  alias Loverage.Pickup
  alias Loverage.Pickup.HotTopic

  action_fallback LoverageWeb.FallbackController

  def index(conn,hot_topics_params) do
    hottopics = Pickup.list_hottopics(hot_topics_params)
    render(conn, "index.json", hot_topics: hottopics)
  end

  def create(conn, %{"hot_topic" => hot_topic_params}) do
    case Pickup.create_hot_topic(hot_topic_params) do
      # 成功時
      {:ok, %HotTopic{} = hottopic} ->
        conn |> rep_created(hottopic)
      # 失敗時
      {:error, %{errors: error_list}} ->
        case error_list[:post_id] do
          {"has already been taken", _ } ->
            case Pickup.override_hot_topic_updated_at(hot_topic_params) do
              {:ok, %HotTopic{} = hottopic} ->
                conn |> rep_created(hottopic)
            end
        end
    end
  end

  def show(conn, %{"id" => id}) do
    hottopic = Pickup.get_hot_topic!(id)
    render(conn, "show.json", hot_topic: hottopic)
  end

  defp rep_created(conn, hottopic) do
    conn
        |> put_status(:created)
        |> put_resp_header("location", hot_topic_path(conn, :show, hottopic))
        |> render("created.json", hot_topic: hottopic)
  end
end
