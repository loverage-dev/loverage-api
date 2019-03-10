defmodule Loverage.Repo.Migrations.AddPostIdToFeatureds do
  use Ecto.Migration

  def change do
    alter table(:featureds) do
      add :post_id, references(:posts, on_delete: :delete_all)
    end
  end
end
