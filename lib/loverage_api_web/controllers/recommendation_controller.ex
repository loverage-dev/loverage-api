defmodule LoverageWeb.RecommendationController do
  @moduledoc """
    The Recommendation Controller
    ・Editor's Pick情報にアクセスするためのAPIを定義
  """
  use LoverageWeb, :controller

  alias Loverage.Pickup
  alias Loverage.Pickup.Recommendation

  action_fallback LoverageWeb.FallbackController

  def index(conn,recommendations_params) do
    recommendations = Pickup.list_recommendations(recommendations_params)
    render(conn, "index.json", recommendations: recommendations)
  end

  def index_random(conn,recommendations_params) do
    recommendations = Pickup.list_recommendations_at_random(recommendations_params)
    render(conn, "index.json", recommendations: recommendations)
  end

  def create(conn, %{"editors_pick" => recommendations_params}) do
    case Pickup.create_recommendation(recommendations_params) do
      # 成功時
      {:ok, %Recommendation{} = recommendation} ->
        conn |> rep_created(recommendation)
      # 失敗時
      {:error, %{errors: error_list}} ->
        case error_list[:post_id] do
          {"has already been taken", _ } ->
            case Pickup.override_recommendation_updated_at(recommendations_params) do
              {:ok, %Recommendation{} = recommendation} ->
                conn |> rep_created(recommendation)
            end
        end
    end
  end



  def delete(conn, %{"id" => id}) do
    r = Pickup.get_recommendation!(id)
    with {:ok, %r{}} <- Pickup.delete_recommendation(r) do
      render(conn, "delete.json", recommendation: r)
      #send_resp(conn, :no_content, "")
    end
  end

  def show(conn, %{"id" => id}) do
    recommendation = Pickup.get_recommendation!(id)
    render(conn, "show.json", recommendation: recommendation)
  end

  defp rep_created(conn, recommendation) do
    conn
        |> put_status(:created)
        |> put_resp_header("location", recommendation_path(conn, :show, recommendation))
        |> render("created.json", recommendation: recommendation)
  end
end
