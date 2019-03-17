defmodule Loverage.Pickup.Recommendation do
  @moduledoc """
    The Recommendation schema.
    ・Editor's Pickのモデルを定義
  """
  use Ecto.Schema
  import Ecto.Changeset


  schema "recommendations" do
    field :keyword, :string
    timestamps(type: utc_datetime)

    # リレーション設定
    belongs_to :posts, Loverage.Discussion.Post, foreign_key: :post_id
  end

  @doc false
  def changeset(recommendation, attrs) do
    recommendation
    |> cast(attrs, [:keyword, :post_id])
    |> validate_required([:post_id])
    |> unique_constraint(:post_id)
  end

  def changeset_ignore_post_id_constraint(recommendation, attrs) do
    recommendation
    |> cast(attrs, [:keyword, :post_id])
    |> validate_required([:post_id])
  end
end
