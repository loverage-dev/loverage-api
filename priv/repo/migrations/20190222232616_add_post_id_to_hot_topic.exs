defmodule Loverage.Repo.Migrations.AddPostIdToHotTopic do
  use Ecto.Migration

  def change do
    alter table(:hottopics) do
      add :post_id, references(:posts, on_delete: :delete_all)
    end
  end
end
