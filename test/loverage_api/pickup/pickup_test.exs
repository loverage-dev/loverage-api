defmodule Loverage.PickupTest do
  use Loverage.DataCase

  alias Loverage.Pickup
  alias Loverage.Discussion
  alias Loverage.Discussion.Post

  @valid_post_attrs %{content: "some content" ,age: "e_20s", sex: "m"}
  def post_setup do
    {:ok, post} = %{}
      |> Enum.into(@valid_post_attrs)
      |> Discussion.create_post()
    post
  end

  describe "hottopics" do
    alias Loverage.Pickup.HotTopic

    @valid_attrs %{keyword: "some keyword"}
    @update_attrs %{keyword: "some updated keyword"}
    @invalid_attrs %{keyword: nil, post_id: nil}

    def hot_topic_fixture(attrs \\ %{}) do
      {:ok, hot_topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickup.create_hot_topic()

      hot_topic
    end

    test "list_hottopics/0 returns all hottopics" do
      post = post_setup()
      hot_topic = hot_topic_fixture(%{post_id: post.id})
      assert Pickup.list_hottopics() == [hot_topic]
    end

    test "get_hot_topic!/1 returns the hot_topic with given id" do
      post = post_setup()
      hot_topic = hot_topic_fixture(%{post_id: post.id})
      # preload しておく
      hot_topic = Repo.preload(hot_topic, [{:posts, :reviews}])
      assert Pickup.get_hot_topic!(hot_topic.id) == hot_topic
    end

    test "create_hot_topic/1 with valid data creates a hot_topic" do
      post = post_setup()
      assert {:ok, %HotTopic{} = hot_topic} = @valid_attrs |> Enum.into(%{post_id: post.id}) |> Pickup.create_hot_topic()
      assert hot_topic.keyword == "some keyword"
    end

    test "create_hot_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickup.create_hot_topic(@invalid_attrs)
    end

    test "update_hot_topic/2 with valid data updates the hot_topic" do
      post = post_setup()
      hot_topic = hot_topic_fixture(%{post_id: post.id})
      assert {:ok, hot_topic} = Pickup.update_hot_topic(hot_topic, @update_attrs)
      assert %HotTopic{} = hot_topic
      assert hot_topic.keyword == "some updated keyword"
    end

    test "update_hot_topic/2 with invalid data returns error changeset" do
      post = post_setup()
      hot_topic = hot_topic_fixture(%{post_id: post.id})
      # preload しておく
      hot_topic = Repo.preload(hot_topic, [{:posts, :reviews}])
      assert {:error, %Ecto.Changeset{}} = Pickup.update_hot_topic(hot_topic, @invalid_attrs)
      assert hot_topic == Pickup.get_hot_topic!(hot_topic.id)
    end

    test "delete_hot_topic/1 deletes the hot_topic" do
      post = post_setup()
      hot_topic = hot_topic_fixture(%{post_id: post.id})
      assert {:ok, %HotTopic{}} = Pickup.delete_hot_topic(hot_topic)
      assert_raise Ecto.NoResultsError, fn -> Pickup.get_hot_topic!(hot_topic.id) end
    end

    test "change_hot_topic/1 returns a hot_topic changeset" do
      post = post_setup()
      hot_topic = hot_topic_fixture(%{post_id: post.id})
      assert %Ecto.Changeset{} = Pickup.change_hot_topic(hot_topic)
    end
  end

  describe "recommendations" do
    alias Loverage.Pickup.Recommendation

    @valid_attrs %{keyword: "some keyword", message: "some message"}
    @update_attrs %{keyword: "some updated keyword", message: "some update message"}
    @invalid_attrs %{keyword: nil}

    def recommendation_fixture(attrs \\ %{}) do
      {:ok, recommendation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickup.create_recommendation()

      recommendation
    end

    test "list_recommendations/0 returns all recommendations" do
      post = post_setup()
      recommendation = recommendation_fixture(%{post_id: post.id})
      assert Pickup.list_recommendations() == [recommendation]
    end

    test "get_recommendation!/1 returns the recommendation with given id" do
      post = post_setup()
      recommendation = recommendation_fixture(%{post_id: post.id})
      # preload しておく
      recommendation = Repo.preload(recommendation, [{:posts, :reviews}])
      assert Pickup.get_recommendation!(recommendation.id) == recommendation
    end

    test "create_recommendation/1 with valid data creates a recommendation" do
      post = post_setup()
      assert {:ok, %Recommendation{} = recommendation} = @valid_attrs
        |> Enum.into(%{post_id: post.id})
        |> Pickup.create_recommendation()
      assert recommendation.keyword == "some keyword"
    end

    test "create_recommendation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickup.create_recommendation(@invalid_attrs)
    end

    test "update_recommendation/2 with valid data updates the recommendation" do
      post = post_setup()
      recommendation = recommendation_fixture(%{post_id: post.id})
      assert {:ok, recommendation} = Pickup.update_recommendation(recommendation, @update_attrs)
      assert %Recommendation{} = recommendation
      assert recommendation.keyword == "some updated keyword"
    end

    test "update_recommendation/2 with invalid data returns error changeset" do
      post = post_setup()
      recommendation = recommendation_fixture(%{post_id: post.id})
      assert {:error, %Ecto.Changeset{}} = Pickup.update_recommendation(recommendation, @invalid_attrs)
      assert recommendation == Pickup.get_recommendation!(recommendation.id)
    end

    test "delete_recommendation/1 deletes the recommendation" do
      post = post_setup()
      recommendation = recommendation_fixture(%{post_id: post.id})
      assert {:ok, %Recommendation{}} = Pickup.delete_recommendation(recommendation)
      assert_raise Ecto.NoResultsError, fn -> Pickup.get_recommendation!(recommendation.id) end
    end

    test "change_recommendation/1 returns a recommendation changeset" do
      post = post_setup()
      recommendation = recommendation_fixture(%{post_id: post.id})
      assert %Ecto.Changeset{} = Pickup.change_recommendation(recommendation)
    end
  end

  describe "featureds" do
    alias Loverage.Pickup.Featured

    @valid_attrs %{keyword: "some keyword"}
    @update_attrs %{keyword: "some updated keyword"}
    @invalid_attrs %{keyword: nil, post_id: nil}

    def featured_fixture(attrs \\ %{}) do
      {:ok, featured} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickup.create_featured()

      featured
    end

    test "list_featureds/0 returns all featureds" do
      post = post_setup()
      featured = featured_fixture(%{post_id: post.id})
      assert Pickup.list_featureds() == [featured]
    end

    test "get_featured!/1 returns the featured with given id" do
      post = post_setup()
      featured = featured_fixture(%{post_id: post.id})
      # preload しておく
      featured = Repo.preload(featured, [{:posts, :reviews}])
      assert Pickup.get_featured!(featured.id) == featured
    end

    test "create_featured/1 with valid data creates a featured" do
      post = post_setup()
      assert {:ok, %Featured{} = featured} = %{post_id: post.id}
        |> Enum.into(@valid_attrs)
        |> Pickup.create_featured()
      assert featured.keyword == "some keyword"
    end

    test "create_featured/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickup.create_featured(@invalid_attrs)
    end

    test "update_featured/2 with valid data updates the featured" do
      post = post_setup()
      featured = featured_fixture(%{post_id: post.id})
      assert {:ok, featured} = Pickup.update_featured(featured, @update_attrs)
      assert %Featured{} = featured
      assert featured.keyword == "some updated keyword"
    end

    test "update_featured/2 with invalid data returns error changeset" do
      post = post_setup()
      featured = featured_fixture(%{post_id: post.id})
      assert {:error, %Ecto.Changeset{}} = Pickup.update_featured(featured, @invalid_attrs)
      # preload しておく
      featured = Repo.preload(featured, [{:posts, :reviews}])
      assert featured == Pickup.get_featured!(featured.id)
    end

    test "delete_featured/1 deletes the featured" do
      post = post_setup()
      featured = featured_fixture(%{post_id: post.id})
      assert {:ok, %Featured{}} = Pickup.delete_featured(featured)
      assert_raise Ecto.NoResultsError, fn -> Pickup.get_featured!(featured.id) end
    end

    test "change_featured/1 returns a featured changeset" do
      post = post_setup()
      featured = featured_fixture(%{post_id: post.id})
      assert %Ecto.Changeset{} = Pickup.change_featured(featured)
    end
  end
end
