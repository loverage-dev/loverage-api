defmodule Loverage.Repo.Migrations.CreateVisuals do
  use Ecto.Migration

  def change do
    create table(:visuals) do
      add :day_of_week_no, :integer
      add :type, :string

      timestamps()
    end

  end
end
