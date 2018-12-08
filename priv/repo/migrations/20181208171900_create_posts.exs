defmodule Taqnews.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :link, :string
      add :description, :string
      add :week_id, references(:weeks, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:posts, [:week_id])
  end
end
