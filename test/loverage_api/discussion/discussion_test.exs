defmodule Loverage.DiscussionTest do
  use Loverage.DataCase

  alias Loverage.Discussion

  describe "posts" do
    alias Loverage.Discussion.Post

    @valid_attrs %{content: "some content", age: "e_20s", sex: "m"}
    @update_attrs %{age: "e_30s", sex: "f"}
    @invalid_attrs %{content: "some update content", age: nil, sex: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, %Post{} = post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Discussion.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Discussion.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      # preload してからアサーション
      post = Repo.preload(post, :reviews)
      assert Discussion.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Discussion.create_post(@valid_attrs)
      assert post.age == "e_20s"
      assert post.sex == "m"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Discussion.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Discussion.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.age == "e_30s"
      assert post.sex == "f"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Discussion.update_post(post, @invalid_attrs)
      # preload してからアサーション
      post = Repo.preload(post, :reviews)
      assert Discussion.get_post!(post.id) == post
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Discussion.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Discussion.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Discussion.change_post(post)
    end
  end

  describe "reviews" do
    alias Loverage.Discussion.Review
    alias Loverage.Discussion.Post

    @valid_post_attrs %{content: "some content" ,age: "e_20s", sex: "m"}
    def post_setup do
      {:ok, post} = %{}
        |> Enum.into(@valid_post_attrs)
        |> Discussion.create_post()
      post
    end

    @valid_attrs %{age: "e_20s", selected_opt: "opt1", sex: "m"}
    @update_attrs %{age: "e_30s", selected_opt: "opt2", sex: "f"}
    @invalid_attrs %{age: nil, selected_opt: nil, sex: nil}

    def review_fixture(attrs \\ %{}) do
      {:ok, review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Discussion.create_review()

      review
    end

    test "list_reviews/0 returns all reviews" do
      post = post_setup()
      review = review_fixture(%{post_id: post.id})
      assert Discussion.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      post = post_setup()
      review = review_fixture(%{post_id: post.id})
      assert Discussion.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      post = post_setup()
      review = %{post_id: post.id} |> Enum.into(@valid_attrs)
      assert {:ok, %Review{} = review} = Discussion.create_review(review)
      assert review.age == "e_20s"
      assert review.selected_opt == "opt1"
      assert review.sex == "m"
    end

    test "create_review/1 with invalid data returns error changeset" do
      post = post_setup()
      review = %{post_id: post.id} |> Enum.into(@invalid_attrs)
      assert {:error, %Ecto.Changeset{}} = Discussion.create_review(review)
    end

    test "update_review/2 with valid data updates the review" do
      post = post_setup()
      review = review_fixture(%{post_id: post.id})
      upreview = %{post_id: post.id} |> Enum.into(@update_attrs)
      assert {:ok, review} = Discussion.update_review(review, upreview)
      assert %Review{} = review
      assert review.age == "e_30s"
      assert review.selected_opt == "opt2"
      assert review.sex == "f"
    end

    test "update_review/2 with invalid data returns error changeset" do
      post = post_setup()
      review = review_fixture(%{post_id: post.id})
      assert {:error, %Ecto.Changeset{}} = Discussion.update_review(review, @invalid_attrs)
      assert review == Discussion.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      post = post_setup()
      review = review_fixture(%{post_id: post.id})
      assert {:ok, %Review{}} = Discussion.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Discussion.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      post = post_setup()
      review = review_fixture(%{post_id: post.id})
      assert %Ecto.Changeset{} = Discussion.change_review(review)
    end
  end
end
