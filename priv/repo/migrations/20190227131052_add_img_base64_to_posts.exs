defmodule Loverage.Repo.Migrations.AddImgBase64ToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :img_base64, :text
    end
  end
end
