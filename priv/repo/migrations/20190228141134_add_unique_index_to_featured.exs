defmodule Loverage.Repo.Migrations.AddUniqueIndexToFeatured do
  use Ecto.Migration

  def change do
    create unique_index(:featureds, [:post_id])
  end
end
