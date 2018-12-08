defmodule TaqnewsWeb.PostController do
  use TaqnewsWeb, :controller

  alias Taqnews.News
  alias Taqnews.News.Post

  action_fallback TaqnewsWeb.FallbackController

  def action(conn, _) do
    week = News.get_week!(conn.params["week_id"])
    args = [conn, conn.params, week]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, week) do
    posts = News.list_posts(week)
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}, week) do
    post_params =
      post_params
      |> Map.put("week_id", week.id)

    with {:ok, %Post{} = post} <- News.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.week_post_path(conn, :show, week.id, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}, week) do
    post = News.get_post!(week, id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}, week) do
    post = News.get_post!(week, id)

    with {:ok, %Post{} = post} <- News.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}, week) do
    post = News.get_post!(week, id)

    with {:ok, %Post{}} <- News.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
