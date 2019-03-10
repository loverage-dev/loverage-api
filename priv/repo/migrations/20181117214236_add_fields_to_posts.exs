defmodule Loverage.Repo.Migrations.AddFieldsToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :tag_list, {:array, :string}
      add :category, :string
      add :ref_count, :integer
    end
  end
end
