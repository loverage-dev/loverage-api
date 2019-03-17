defmodule Loverage.Pickup.Featured do
  @moduledoc """
    The Featured schema.
    ・Featuredのモデルを定義
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "featureds" do
    field :keyword, :string
    timestamps(type: :timestamptz)

    # リレーション設定
    belongs_to :posts, Loverage.Discussion.Post, foreign_key: :post_id
  end

  @doc false
  def changeset(featured, attrs) do
    featured
    |> cast(attrs, [:keyword, :post_id])
    |> validate_required([:post_id])
    |> unique_constraint(:post_id)
  end

  def changeset_ignore_post_id_constraint(featured, attrs) do
    featured
    |> cast(attrs, [:keyword, :post_id])
    |> validate_required([:post_id])
  end
end
