defmodule LoverageWeb.CategoryView do
    use LoverageWeb, :view
    alias LoverageWeb.CategoryView
    alias LoverageWeb.PostView
  
    def render("index.json", %{categories: categories}) do
      %{categories: render_many(categories, CategoryView, "category.json")}
    end
  
    def render("show.json", %{category: category}) do
      %{category: render_one(category, CategoryView, "category.json")}
    end
  
    def render("category.json", %{category: category}) do
      %{
        id: category.id,
        name: category.name,
        posts: render_many(category.posts, PostView, "post_overview.json")
       }
    end
  
    def render("created.json", %{category: category}) do
      %{
        id: category.id,
        name: category.name,
        message: "categoryへ登録しました。"
      }
    end
    
    def render("updated.json", %{category: category}) do
      %{
        id: category.id,
        name: category.name,
        message: "categoryを更新しました。"
      }
    end

    def render("delete.json", %{category: category}) do
     %{
        message: "categoryから削除しました。"
      }
    end
  end
  