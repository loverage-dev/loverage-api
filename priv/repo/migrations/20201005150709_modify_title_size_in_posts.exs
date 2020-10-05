defmodule Loverage.Repo.Migrations.ModifyTitleSizeInPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :title, :string, size: 38
    end
  end
end
