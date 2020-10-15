defmodule Loverage.Repo.Migrations.AddTitleToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :title, :string, size: 32
    end
  end
end
