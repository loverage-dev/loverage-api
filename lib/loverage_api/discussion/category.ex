defmodule Loverage.Discussion.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "categories" do
    field :name, :string
    field :description, :string

      # リレーション設定
      has_many :posts, Loverage.Discussion.Post
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
