defmodule Loverage.Repo.Migrations.CreateFeatureds do
  use Ecto.Migration

  def change do
    create table(:featureds) do
      add :keyword, :string

      timestamps()
    end

  end
end
