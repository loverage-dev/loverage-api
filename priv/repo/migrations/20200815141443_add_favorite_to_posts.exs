defmodule Loverage.Repo.Migrations.AddFavoriteToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :favorite, :integer
    end
  end
end
