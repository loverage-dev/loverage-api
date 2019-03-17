defmodule Loverage.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string
      add :is_active, :boolean, default: false, null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:users, [:email])
  end
end
