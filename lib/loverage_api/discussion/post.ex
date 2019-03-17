defmodule Loverage.Discussion.Post do
  @moduledoc """
    The Post schema.
    ・投稿記事のモデルを定義
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do

    field :name, :string, default: "Unknown"    #名前
    field :age, :string                         #年齢（e_10s/l_10s/e_20s/l_20s/e_30s/l_30s/e_40s/l_40s/e_50s/l_50s/e_60s/l_60s）
    field :sex, :string                         #性別（m/f/o）
    field :content, :string                    #本文
    field :opt1, :string, default: "アリ"       #選択肢①
    field :opt2, :string, default: "ナシ"       #選択肢②
    field :tag_list, {:array, :string} , default: []   #タグ
    field :category, :string , default: ""             #カテゴリ
    field :ref_count, :integer, default: 0      #参照回数
    field :reviews_amount, :integer, default: 0 #投票総数
    field :img_fmt, :string, default: ""        #ファイル拡張子（画像）
    field :img_base64, :string, default: ""     #Base64文字列（画像）

    # リレーション設定
    has_many :reviews, Loverage.Discussion.Review
    has_one :hottopics, Loverage.Pickup.HotTopic
    has_one :recommendations, Loverage.Pickup.Recommendation
    has_one :featureds, Loverage.Pickup.Featured

    timestamps(type: :timestamptz)

  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :sex, :age, :content, :opt1, :opt2, :tag_list, :category, :ref_count, :img_fmt, :img_base64])
    |> validate_required([:sex, :age, :content])
    |> validate_inclusion(:age, ["e_10s", "l_10s", "e_20s", "l_20s","e_30s", "l_30s","e_40s", "l_40s","e_50s", "l_50s","e_60s", "l_60s"])
    |> validate_inclusion(:sex, ["m", "f", "o"])
    |> validate_inclusion(:img_fmt, ["jpg", "jpeg", "png", "gif"])
  end
end
