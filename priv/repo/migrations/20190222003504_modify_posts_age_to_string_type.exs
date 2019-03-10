defmodule Loverage.Repo.Migrations.ModifyPostsAgeToStringType do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :age, :string
    end
  end
end
