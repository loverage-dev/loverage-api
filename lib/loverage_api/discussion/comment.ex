defmodule Loverage.Discussion.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :content, :string
    field :age, :string                         #年齢（e_10s/l_10s/e_20s/l_20s/e_30s/l_30s/e_40s/l_40s/e_50s/l_50s/e_60s/l_60s）
    field :sex, :string                         #性別（m/f/o）
    field :icon_id, :string                     #アイコン識別子
    field :stars, :integer, default: 0          #お気に入り数
    field :priority, :integer, default: 0       #表示優先度
    field :selected_opt, :string                #回答した選択肢(opt1/opt2)
    
    # リレーション設定
    belongs_to :post, Loverage.Discussion.Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
  IO.inspect(attrs)
    comment
    |> cast(attrs, [:content, :sex, :age, :icon_id, :selected_opt, :post_id])
    |> validate_required([:content, :sex, :age, :icon_id, :selected_opt, :post_id])
    |> validate_inclusion(:age, ["e_10s", "l_10s", "e_20s", "l_20s","e_30s", "l_30s","e_40s", "l_40s","e_50s", "l_50s","e_60s", "l_60s"])
    |> validate_inclusion(:sex, ["m", "f", "o"])
    |> validate_inclusion(:selected_opt, ["opt1", "opt2"])
  end
end
