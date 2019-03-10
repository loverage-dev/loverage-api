defmodule Loverage.Repo.Migrations.AddReviewsAmountToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :reviews_amount, :integer
    end
  end
end
