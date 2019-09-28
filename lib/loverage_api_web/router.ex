defmodule LoverageWeb.Router do
  @moduledoc """
    The Router
    ・APIのURIを定義する
  """
  use LoverageWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  # ルーティング設定
  scope "/api/v1", LoverageWeb do
    pipe_through :api
    # =============    一般向けAPI　　=========================
    get "/overview", CommonController, :indexies
    get "/articles", PostController, :index
    get "/articles/:id", PostController, :show
    get "/ranking_view", PostController, :ranking_view
    get "/ranking_vote", PostController, :ranking_vote
    get "/hot_topics", HotTopicController, :index
    get "/hot_topics/:id", HotTopicController, :show
    get "/editors_picks", RecommendationController, :index
    get "/editors_picks/:id", RecommendationController, :show
    get "/latest", PostController, :index_latest
    get "/latest/:id", PostController, :show
    get "/featureds", FeaturedController, :index
    get "/featureds/:id", FeaturedController, :show
    post "/articles", PostController, :create
    post "/articles/:id/vote", ReviewController, :create
    post "/articles/:id/comment", CommentController, :create
    # =============    管理向けAPI　　=========================
    post "/articles/hot_topic", HotTopicController, :create
    post "/articles/featured", FeaturedController, :create
    delete "/articles/featured/:id", FeaturedController, :delete
    delete "/articles/:id", PostController, :delete
    delete "/articles/hot_topic/:id", HotTopicController, :delete
    delete "/articles/editors_pick/:id", RecommendationController, :delete
    post "/articles/editors_pick", RecommendationController, :create
    post "/users/sign_in", UserController, :sign_in
    get "/votes/:id", ReviewController, :show
    post "/comments/:id", CommentController, :update
    get "/comments/:id", CommentController, :show
    delete "comments/:id", CommentController, :delete
    get "/comments", CommentController, :index
    post "/articles/:id/update", PostController, :update
    post "/articles/set_eye_catching", PostController, :set_eye_catching
    post "/articles/up_to_pickup", PostController, :update_datetime
    post "/visuals", VisualController, :create
    post "/visuals/:id", VisualController, :update
    delete "/visuals/:id", VisualController, :delete
    get "/visuals", VisualController, :index
    get "/visuals/:id", VisualController, :show
    get "/categories/:id", CategoryController, :show
    get "/categories", CategoryController, :index
    post "/categories", CategoryController, :create
    post "/categories/:id/update", CategoryController, :update
    delete "/categories/:id", CategoryController, :delete
    
    # ================================================
  end

  # 管理者限定
  scope "/api/v1", LoverageWeb do
    pipe_through [:api, :api_auth]
    resources "/users", UserController, except: [:new, :edit]
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(LoverageWeb.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt()
    end
  end

end
