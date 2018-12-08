defmodule Taqnews.News.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :link, :string
    field :title, :string
    field :week_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :link, :description, :week_id])
    |> validate_required([:title, :link, :description, :week_id])
    |> unique_constraint(:week_id)
  end
end
