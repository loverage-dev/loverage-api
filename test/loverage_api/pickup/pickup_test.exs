defmodule Loverage.PickupTest do
  use Loverage.DataCase

  alias Loverage.Pickup

  describe "hottopics" do
    alias Loverage.Pickup.HotTopic

    @valid_attrs %{keyword: "some keyword"}
    @update_attrs %{keyword: "some updated keyword"}
    @invalid_attrs %{keyword: nil}

    def hot_topic_fixture(attrs \\ %{}) do
      {:ok, hot_topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickup.create_hot_topic()

      hot_topic
    end

    test "list_hottopics/0 returns all hottopics" do
      hot_topic = hot_topic_fixture()
      assert Pickup.list_hottopics() == [hot_topic]
    end

    test "get_hot_topic!/1 returns the hot_topic with given id" do
      hot_topic = hot_topic_fixture()
      assert Pickup.get_hot_topic!(hot_topic.id) == hot_topic
    end

    test "create_hot_topic/1 with valid data creates a hot_topic" do
      assert {:ok, %HotTopic{} = hot_topic} = Pickup.create_hot_topic(@valid_attrs)
      assert hot_topic.keyword == "some keyword"
    end

    test "create_hot_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickup.create_hot_topic(@invalid_attrs)
    end

    test "update_hot_topic/2 with valid data updates the hot_topic" do
      hot_topic = hot_topic_fixture()
      assert {:ok, hot_topic} = Pickup.update_hot_topic(hot_topic, @update_attrs)
      assert %HotTopic{} = hot_topic
      assert hot_topic.keyword == "some updated keyword"
    end

    test "update_hot_topic/2 with invalid data returns error changeset" do
      hot_topic = hot_topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Pickup.update_hot_topic(hot_topic, @invalid_attrs)
      assert hot_topic == Pickup.get_hot_topic!(hot_topic.id)
    end

    test "delete_hot_topic/1 deletes the hot_topic" do
      hot_topic = hot_topic_fixture()
      assert {:ok, %HotTopic{}} = Pickup.delete_hot_topic(hot_topic)
      assert_raise Ecto.NoResultsError, fn -> Pickup.get_hot_topic!(hot_topic.id) end
    end

    test "change_hot_topic/1 returns a hot_topic changeset" do
      hot_topic = hot_topic_fixture()
      assert %Ecto.Changeset{} = Pickup.change_hot_topic(hot_topic)
    end
  end

  describe "recommendations" do
    alias Loverage.Pickup.Recommendation

    @valid_attrs %{keyword: "some keyword"}
    @update_attrs %{keyword: "some updated keyword"}
    @invalid_attrs %{keyword: nil}

    def recommendation_fixture(attrs \\ %{}) do
      {:ok, recommendation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickup.create_recommendation()

      recommendation
    end

    test "list_recommendations/0 returns all recommendations" do
      recommendation = recommendation_fixture()
      assert Pickup.list_recommendations() == [recommendation]
    end

    test "get_recommendation!/1 returns the recommendation with given id" do
      recommendation = recommendation_fixture()
      assert Pickup.get_recommendation!(recommendation.id) == recommendation
    end

    test "create_recommendation/1 with valid data creates a recommendation" do
      assert {:ok, %Recommendation{} = recommendation} = Pickup.create_recommendation(@valid_attrs)
      assert recommendation.keyword == "some keyword"
    end

    test "create_recommendation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickup.create_recommendation(@invalid_attrs)
    end

    test "update_recommendation/2 with valid data updates the recommendation" do
      recommendation = recommendation_fixture()
      assert {:ok, recommendation} = Pickup.update_recommendation(recommendation, @update_attrs)
      assert %Recommendation{} = recommendation
      assert recommendation.keyword == "some updated keyword"
    end

    test "update_recommendation/2 with invalid data returns error changeset" do
      recommendation = recommendation_fixture()
      assert {:error, %Ecto.Changeset{}} = Pickup.update_recommendation(recommendation, @invalid_attrs)
      assert recommendation == Pickup.get_recommendation!(recommendation.id)
    end

    test "delete_recommendation/1 deletes the recommendation" do
      recommendation = recommendation_fixture()
      assert {:ok, %Recommendation{}} = Pickup.delete_recommendation(recommendation)
      assert_raise Ecto.NoResultsError, fn -> Pickup.get_recommendation!(recommendation.id) end
    end

    test "change_recommendation/1 returns a recommendation changeset" do
      recommendation = recommendation_fixture()
      assert %Ecto.Changeset{} = Pickup.change_recommendation(recommendation)
    end
  end

  describe "featureds" do
    alias Loverage.Pickup.Featured

    @valid_attrs %{keyword: "some keyword"}
    @update_attrs %{keyword: "some updated keyword"}
    @invalid_attrs %{keyword: nil}

    def featured_fixture(attrs \\ %{}) do
      {:ok, featured} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickup.create_featured()

      featured
    end

    test "list_featureds/0 returns all featureds" do
      featured = featured_fixture()
      assert Pickup.list_featureds() == [featured]
    end

    test "get_featured!/1 returns the featured with given id" do
      featured = featured_fixture()
      assert Pickup.get_featured!(featured.id) == featured
    end

    test "create_featured/1 with valid data creates a featured" do
      assert {:ok, %Featured{} = featured} = Pickup.create_featured(@valid_attrs)
      assert featured.keyword == "some keyword"
    end

    test "create_featured/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickup.create_featured(@invalid_attrs)
    end

    test "update_featured/2 with valid data updates the featured" do
      featured = featured_fixture()
      assert {:ok, featured} = Pickup.update_featured(featured, @update_attrs)
      assert %Featured{} = featured
      assert featured.keyword == "some updated keyword"
    end

    test "update_featured/2 with invalid data returns error changeset" do
      featured = featured_fixture()
      assert {:error, %Ecto.Changeset{}} = Pickup.update_featured(featured, @invalid_attrs)
      assert featured == Pickup.get_featured!(featured.id)
    end

    test "delete_featured/1 deletes the featured" do
      featured = featured_fixture()
      assert {:ok, %Featured{}} = Pickup.delete_featured(featured)
      assert_raise Ecto.NoResultsError, fn -> Pickup.get_featured!(featured.id) end
    end

    test "change_featured/1 returns a featured changeset" do
      featured = featured_fixture()
      assert %Ecto.Changeset{} = Pickup.change_featured(featured)
    end
  end

  describe "visuals" do
    alias Loverage.Pickup.Visual

    @valid_attrs %{day_of_week_no: 42, type: "some type"}
    @update_attrs %{day_of_week_no: 43, type: "some updated type"}
    @invalid_attrs %{day_of_week_no: nil, type: nil}

    def visual_fixture(attrs \\ %{}) do
      {:ok, visual} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickup.create_visual()

      visual
    end

    test "list_visuals/0 returns all visuals" do
      visual = visual_fixture()
      assert Pickup.list_visuals() == [visual]
    end

    test "get_visual!/1 returns the visual with given id" do
      visual = visual_fixture()
      assert Pickup.get_visual!(visual.id) == visual
    end

    test "create_visual/1 with valid data creates a visual" do
      assert {:ok, %Visual{} = visual} = Pickup.create_visual(@valid_attrs)
      assert visual.day_of_week_no == 42
      assert visual.type == "some type"
    end

    test "create_visual/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickup.create_visual(@invalid_attrs)
    end

    test "update_visual/2 with valid data updates the visual" do
      visual = visual_fixture()
      assert {:ok, visual} = Pickup.update_visual(visual, @update_attrs)
      assert %Visual{} = visual
      assert visual.day_of_week_no == 43
      assert visual.type == "some updated type"
    end

    test "update_visual/2 with invalid data returns error changeset" do
      visual = visual_fixture()
      assert {:error, %Ecto.Changeset{}} = Pickup.update_visual(visual, @invalid_attrs)
      assert visual == Pickup.get_visual!(visual.id)
    end

    test "delete_visual/1 deletes the visual" do
      visual = visual_fixture()
      assert {:ok, %Visual{}} = Pickup.delete_visual(visual)
      assert_raise Ecto.NoResultsError, fn -> Pickup.get_visual!(visual.id) end
    end

    test "change_visual/1 returns a visual changeset" do
      visual = visual_fixture()
      assert %Ecto.Changeset{} = Pickup.change_visual(visual)
    end
  end
end
