defmodule Loverage.DiscussionTest do
  use Loverage.DataCase

  alias Loverage.Discussion

  describe "posts" do
    alias Loverage.Discussion.Post

    @valid_attrs %{age: 42, sex: 42}
    @update_attrs %{age: 43, sex: 43}
    @invalid_attrs %{age: nil, sex: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
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
      assert Discussion.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Discussion.create_post(@valid_attrs)
      assert post.age == 42
      assert post.sex == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Discussion.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Discussion.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.age == 43
      assert post.sex == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Discussion.update_post(post, @invalid_attrs)
      assert post == Discussion.get_post!(post.id)
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

    @valid_attrs %{age: 42, selected_opt: "some selected_opt", sex: 42}
    @update_attrs %{age: 43, selected_opt: "some updated selected_opt", sex: 43}
    @invalid_attrs %{age: nil, selected_opt: nil, sex: nil}

    def review_fixture(attrs \\ %{}) do
      {:ok, review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Discussion.create_review()

      review
    end

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Discussion.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Discussion.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      assert {:ok, %Review{} = review} = Discussion.create_review(@valid_attrs)
      assert review.age == 42
      assert review.selected_opt == "some selected_opt"
      assert review.sex == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Discussion.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      assert {:ok, review} = Discussion.update_review(review, @update_attrs)
      assert %Review{} = review
      assert review.age == 43
      assert review.selected_opt == "some updated selected_opt"
      assert review.sex == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Discussion.update_review(review, @invalid_attrs)
      assert review == Discussion.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Discussion.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Discussion.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Discussion.change_review(review)
    end
  end
end
