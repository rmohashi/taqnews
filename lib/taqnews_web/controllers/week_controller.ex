defmodule TaqnewsWeb.WeekController do
  use TaqnewsWeb, :controller

  alias Taqnews.News
  alias Taqnews.News.Week

  action_fallback TaqnewsWeb.FallbackController

  def index(conn, _params) do
    weeks = News.list_weeks()
    render(conn, "index.json", weeks: weeks)
  end

  def create(conn, %{"week" => week_params}) do
    with {:ok, %Week{} = week} <- News.create_week(week_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.week_path(conn, :show, week))
      |> render("show.json", week: week)
    end
  end

  def show(conn, %{"id" => id}) do
    week = News.get_week!(id)
    render(conn, "show.json", week: week)
  end

  def update(conn, %{"id" => id, "week" => week_params}) do
    week = News.get_week!(id)

    with {:ok, %Week{} = week} <- News.update_week(week, week_params) do
      render(conn, "show.json", week: week)
    end
  end

  def delete(conn, %{"id" => id}) do
    week = News.get_week!(id)

    with {:ok, %Week{}} <- News.delete_week(week) do
      send_resp(conn, :no_content, "")
    end
  end
end
