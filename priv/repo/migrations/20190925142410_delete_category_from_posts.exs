defmodule Loverage.Repo.Migrations.DeleteCategoryFromPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :category
    end
  end
end
