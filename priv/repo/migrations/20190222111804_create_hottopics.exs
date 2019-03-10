defmodule Loverage.Repo.Migrations.CreateHottopics do
  use Ecto.Migration

  def change do
    create table(:hottopics) do
      add :keyword, :string

      timestamps()
    end

  end
end
