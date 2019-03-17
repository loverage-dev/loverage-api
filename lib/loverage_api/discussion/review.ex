defmodule Loverage.Discussion.Review do
  @moduledoc """
    The Review schema.
    ・投票内容のモデルを定義
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :age, :string           #回答者の年齢（e_10s/l_10s/e_20s/l_20s/e_30s/l_30s/e_40s/l_40s/e_50s/l_50s/e_60s/l_60s）
    field :sex, :string           #回答者の性別（m/f/o）
    field :selected_opt, :string  #回答した選択肢(opt1/opt2)
    timestamps(type: :timestamptz)

    # リレーション設定
    belongs_to :post, Loverage.Discussion.Post
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:sex, :age, :selected_opt, :post_id])
    |> validate_required([:sex, :age, :selected_opt, :post_id])
    |> validate_inclusion(:age, ["e_10s", "l_10s", "e_20s", "l_20s","e_30s", "l_30s","e_40s", "l_40s","e_50s", "l_50s","e_60s", "l_60s"])
    |> validate_inclusion(:sex, ["m", "f", "o"])
    |> validate_inclusion(:selected_opt, ["opt1", "opt2"])
  end
end
