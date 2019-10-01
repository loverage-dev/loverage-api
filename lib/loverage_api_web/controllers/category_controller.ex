defmodule LoverageWeb.CategoryController do
    @moduledoc """
      The Category Controller
      カテゴリー情報にアクセスするためのAPIを定義
    """
    use LoverageWeb, :controller

    alias Loverage.Discussion
    alias Loverage.Discussion.Category
    action_fallback LoverageWeb.FallbackController
  
    def index(conn,category_params) do
      categories = Discussion.list_categories()
      render(conn, "index.json", categories: categories)
    end

    def list(conn,category_params) do
      categories = Discussion.namelist_categories()
      IO.inspect(categories)
      render(conn, "list.json", categories: categories)
    end
  
    def create(conn, %{"category" => category_params}) do
      with {:ok, %Category{} = category} <- Discussion.create_category(category_params) do
        conn
         |> put_status(:created)
         |> put_resp_header("location", category_path(conn, :show, category))
         |> render("created.json", category: category)
      end
    end
  
    def update(conn, %{"id" => id, "category" => category_params}) do
      category = Discussion.get_category!(id)
      with {:ok, %Category{} = category} <- Discussion.update_category(category, category_params) do
        render(conn, "updated.json", category: category)
      end
    end
  
    def delete(conn, %{"id" => id}) do
        c = Discussion.get_category!(id)
      with {:ok, %c{}} <- Discussion.delete_category(c) do
        render(conn, "delete.json", category: c)
        #send_resp(conn, :no_content, "")
      end
    end
  
    def show(conn, %{"id" => id}) do
      category = Discussion.get_category!(id)
      render(conn, "show.json", category: category)
    end
  
    defp rep_created(conn, category) do
      conn
          |> put_status(:created)
          |> put_resp_header("location", category_path(conn, :show, category))
          |> render("created.json", category: category)
    end
  
  end
  