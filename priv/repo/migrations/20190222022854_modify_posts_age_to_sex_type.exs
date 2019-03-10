defmodule Loverage.Repo.Migrations.ModifyPostsAgeToSexType do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :sex, :string
    end
  end
end
