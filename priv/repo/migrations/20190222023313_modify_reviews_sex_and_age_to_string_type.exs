defmodule Loverage.Repo.Migrations.ModifyReviewsSexAndAgeToStringType do
  use Ecto.Migration

  def change do
    alter table(:reviews) do
      modify :age, :string
      modify :sex, :string
    end
  end
end
