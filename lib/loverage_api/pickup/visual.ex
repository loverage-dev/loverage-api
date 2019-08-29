defmodule Loverage.Pickup.Visual do
  use Ecto.Schema
  import Ecto.Changeset


  schema "visuals" do
    field :day_of_week_no, :integer
    field :type, :string

    timestamps(type: :utc_datetime)

    # リレーション設定
    belongs_to :posts, Loverage.Discussion.Post, foreign_key: :post_id
  end

  @doc false
  def changeset(visual, attrs) do
    visual
    |> cast(attrs, [:day_of_week_no, :type, :post_id])
    |> validate_required([:day_of_week_no, :type, :post_id])
    |> validate_inclusion(:day_of_week_no, [1, 2, 3, 4, 5, 6, 7])
    |> validate_inclusion(:type, ["main", "sub"])
    # |> unique_constraint([:day_of_week_no])
  end
end
