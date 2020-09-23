defmodule Loverage.Repo.Migrations.ModifyPostsFavoriteDefault do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :favorite, :integer, default: 0
    end
  end
end
