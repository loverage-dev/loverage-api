defmodule Loverage.Repo.Migrations.CreateRecommendations do
  use Ecto.Migration

  def change do
    create table(:recommendations) do
      add :keyword, :string

      timestamps(type: :timestamptz)
    end

  end
end
