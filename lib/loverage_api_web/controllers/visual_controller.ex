defmodule LoverageWeb.VisualController do
  @moduledoc """
    The Visual Controller
    ・Editor's Pick情報にアクセスするためのAPIを定義
  """
  use LoverageWeb, :controller

  alias Loverage.Pickup
  alias Loverage.Pickup.Visual

  action_fallback LoverageWeb.FallbackController

  def index(conn,visuals_params) do
    visuals = Pickup.list_visuals(visuals_params)
    render(conn, "index.json", visuals: visuals)
  end

  def create(conn, %{"visual" => visual_params}) do
    with {:ok, %Visual{} = visual} <- Pickup.create_visual(visual_params) do
      conn
       |> put_status(:created)
       |> put_resp_header("location", visual_path(conn, :show, visual))
       |> render("created.json", visual: visual)
    end
  end

  def update(conn, %{"id" => id, "visual" => visual_params}) do
    visual = Pickup.get_visual!(id)
    with {:ok, %Visual{} = visual} <- Pickup.update_visual(visual, visual_params) do
      render(conn, "updated.json", visual: visual)
    end
  end

  def delete(conn, %{"id" => id}) do
    v = Pickup.get_visual!(id)
    with {:ok, %v{}} <- Pickup.delete_visual(v) do
      render(conn, "delete.json", visual: v)
      #send_resp(conn, :no_content, "")
    end
  end

  def show(conn, %{"id" => id}) do
    visual = Pickup.get_visual!(id)
    render(conn, "show.json", visual: visual)
  end

  defp rep_created(conn, visual) do
    conn
        |> put_status(:created)
        |> put_resp_header("location", visual_path(conn, :show, visual))
        |> render("created.json", visual: visual)
  end

end
