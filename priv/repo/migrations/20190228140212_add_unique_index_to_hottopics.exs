defmodule Loverage.Repo.Migrations.AddUniqueIndexToHottopics do
  use Ecto.Migration

  def change do
    create unique_index(:hottopics, [:post_id])
  end
end
