defmodule Taqnews.News do
  @moduledoc """
  The News context.
  """

  import Ecto.Query, warn: false
  alias Taqnews.Repo

  alias Taqnews.News.Week
  alias Taqnews.News.Post
  alias Taqnews.News.Comment

  @doc """
  Returns the list of weeks.

  ## Examples

      iex> list_weeks()
      [%Week{}, ...]

  """
  def list_weeks do
    Repo.all(Week)
  end

  @doc """
  Gets a single week.

  Raises `Ecto.NoResultsError` if the Week does not exist.

  ## Examples

      iex> get_week!(123)
      %Week{}

      iex> get_week!(456)
      ** (Ecto.NoResultsError)

  """
  def get_week!(id), do: Repo.get!(Week, id)

  @doc """
  Creates a week.

  ## Examples

      iex> create_week(%{field: value})
      {:ok, %Week{}}

      iex> create_week(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_week(attrs \\ %{}) do
    %Week{}
    |> Week.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a week.

  ## Examples

      iex> update_week(week, %{field: new_value})
      {:ok, %Week{}}

      iex> update_week(week, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_week(%Week{} = week, attrs) do
    week
    |> Week.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Week.

  ## Examples

      iex> delete_week(week)
      {:ok, %Week{}}

      iex> delete_week(week)
      {:error, %Ecto.Changeset{}}

  """
  def delete_week(%Week{} = week) do
    Repo.delete(week)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking week changes.

  ## Examples

      iex> change_week(week)
      %Ecto.Changeset{source: %Week{}}

  """
  def change_week(%Week{} = week) do
    Week.changeset(week, %{})
  end

  def list_posts(week) do
    Post
    |> where([p], p.week_id == ^week.id)
    |> Repo.all
  end

  def get_post!(week, id) do
    Post
    |> where([p], p.week_id == ^week.id)
    |> Repo.get!(id)
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def list_comments(post) do
    Comment
    |> where([c], c.post_id == ^post.id)
    |> Repo.all
  end

  def get_comment!(post, id) do
    Comment
    |> where([c], c.post_id == ^post.id)
    |> Repo.get!(id)
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end
end
