defmodule Loverage.Repo.Migrations.AddImgFmtToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :img_fmt, :string
    end
  end
end
