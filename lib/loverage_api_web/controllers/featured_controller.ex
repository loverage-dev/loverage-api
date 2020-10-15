defmodule LoverageWeb.FeaturedController do
  @moduledoc """
    The Featured Controller
    ・Featured情報にアクセスするためのAPIを定義
  """
  use LoverageWeb, :controller

  alias Loverage.Pickup
  alias Loverage.Pickup.Featured

  action_fallback LoverageWeb.FallbackController

  def index(conn,featureds_params) do
    featureds = Pickup.list_featureds(featureds_params)
    render(conn, "index.json", featureds: featureds)
  end

  def index_random(conn,featureds_params) do
    featureds = Pickup.list_featureds_at_random(featureds_params)
    render(conn, "index.json", featureds: featureds)
  end

  def create(conn, %{"featured" => featureds_params}) do
    case Pickup.create_featured(featureds_params) do
      # 成功時
      {:ok, %Featured{} = featured} ->
        conn |> rep_created(featured)
      # 失敗時
      {:error, %{errors: error_list}} ->
        case error_list[:post_id] do
          {"has already been taken", _ } ->
            case Pickup.override_featured_updated_at(featureds_params) do
              {:ok, %Featured{} = featured} ->
                conn |> rep_created(featured)
            end
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    f = Pickup.get_featured!(id)
    with {:ok, %f{}} <- Pickup.delete_featured(f) do
      render(conn, "delete.json", featured: f)
      #send_resp(conn, :no_content, "")
    end
  end

  def show(conn, %{"id" => id}) do
    featured = Pickup.get_featured!(id)
    render(conn, "show.json", featured: featured)
  end

  defp rep_created(conn, featured) do
    conn
        |> put_status(:created)
        |> put_resp_header("location", featured_path(conn, :show, featured))
        |> render("created.json", featured: featured)
  end
end
