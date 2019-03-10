defmodule Loverage.Repo.Migrations.AddUserNameToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :name, :string
    end
  end
end
