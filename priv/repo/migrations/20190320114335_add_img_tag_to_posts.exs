defmodule Loverage.Repo.Migrations.AddImgTagToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :img_tag, :string
    end
  end
end
