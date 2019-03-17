defmodule Loverage.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :sex, :integer
      add :age, :integer
      add :content, :text
      add :opt1, :string
      add :opt2, :string

      timestamps(type: :timestamptz)
    end

  end
end
