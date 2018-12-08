defmodule Taqnews.News.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :body, :string
    field :user, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user, :post_id])
    |> validate_required([:body, :user, :post_id])
    |> unique_constraint(:post_id)
  end
end
