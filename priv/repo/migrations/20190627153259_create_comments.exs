defmodule Loverage.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment, :text
      add :sex, :string
      add :age, :string
      add :selected_opt, :string
      add :icon_id, :string
      add :stars, :integer
      add :priority, :integer
      add :post_id, references(:posts, on_delete: :delete_all)
      timestamps(type: :timestamptz)
    end

  end
end
