defmodule Taqnews.News.Week do
  use Ecto.Schema
  import Ecto.Changeset


  schema "weeks" do
    field :is_open, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(week, attrs) do
    week
    |> cast(attrs, [:is_open])
    |> validate_required([:is_open])
  end
end
