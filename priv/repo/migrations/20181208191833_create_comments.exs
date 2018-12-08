defmodule Taqnews.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :user, :string
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:comments, [:post_id])
  end
end
