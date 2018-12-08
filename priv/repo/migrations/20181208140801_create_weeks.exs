defmodule Taqnews.Repo.Migrations.CreateWeeks do
  use Ecto.Migration

  def change do
    create table(:weeks) do
      add :is_open, :boolean, default: false, null: false

      timestamps()
    end

  end
end
