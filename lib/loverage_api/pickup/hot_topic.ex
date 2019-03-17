defmodule Loverage.Pickup.HotTopic do
  @moduledoc """
    The HotTopic schema.
    ・HotTopicのモデルを定義
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "hottopics" do
    field :keyword, :string
    timestamps(type: :timestamptz)

    # リレーション設定
    belongs_to :posts, Loverage.Discussion.Post, foreign_key: :post_id
  end

  @doc false
  def changeset(hot_topic, attrs) do
    hot_topic
    |> cast(attrs, [:keyword, :post_id])
    |> validate_required([:post_id])
    |> unique_constraint(:post_id)
  end

  def changeset_ignore_post_id_constraint(hot_topic, attrs) do
    hot_topic
    |> cast(attrs, [:keyword, :post_id])
    |> validate_required([:post_id])
  end
end
