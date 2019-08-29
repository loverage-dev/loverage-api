defmodule Loverage.Repo.Migrations.AddPostIdToVisuals do
  use Ecto.Migration

  def change do
    alter table(:visuals) do
      add :post_id, references(:posts, on_delete: :delete_all)
    end
  end
end
