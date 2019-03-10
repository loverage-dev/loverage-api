defmodule Loverage.Repo.Migrations.AddUniqueIndexToRecommendations do
  use Ecto.Migration

  def change do
    create unique_index(:recommendations, [:post_id])
  end
end
