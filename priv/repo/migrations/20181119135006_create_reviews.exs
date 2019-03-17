defmodule Loverage.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :sex, :integer
      add :age, :integer
      add :selected_opt, :string
      add :post_id, references(:posts, on_delete: :delete_all)
      timestamps(type: :timestamptz)
    end

  end
end
