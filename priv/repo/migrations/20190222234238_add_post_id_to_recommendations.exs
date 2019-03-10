defmodule Loverage.Repo.Migrations.AddPostIdToRecommendations do
  use Ecto.Migration

    def change do
      alter table(:recommendations) do
        add :post_id, references(:posts, on_delete: :delete_all)
      end
    end
end
