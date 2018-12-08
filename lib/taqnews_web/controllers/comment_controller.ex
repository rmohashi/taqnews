defmodule TaqnewsWeb.CommentController do
  use TaqnewsWeb, :controller

  alias Taqnews.News
  alias Taqnews.News.Comment

  action_fallback TaqnewsWeb.FallbackController

  def action(conn, _) do
    week = News.get_week!(conn.params["week_id"])
    post = News.get_post!(week, conn.params["post_id"])
    args = [conn, conn.params, week, post]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, _week, post) do
    comments = News.list_comments(post)
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}, week, post) do
    comment_params =
      comment_params
      |> Map.put("post_id", post.id)

    with {:ok, %Comment{} = comment} <- News.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.week_post_comment_path(conn, :show, week.id, post.id, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}, _week, post) do
    comment = News.get_comment!(post, id)
    render(conn, "show.json", comment: comment)
  end

  def delete(conn, %{"id" => id}, _week, post) do
    comment = News.get_comment!(post, id)

    with {:ok, %Comment{}} <- News.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
