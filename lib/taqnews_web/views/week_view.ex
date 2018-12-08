defmodule TaqnewsWeb.WeekView do
  use TaqnewsWeb, :view
  alias TaqnewsWeb.WeekView

  def render("index.json", %{weeks: weeks}) do
    %{data: render_many(weeks, WeekView, "week.json")}
  end

  def render("show.json", %{week: week}) do
    %{data: render_one(week, WeekView, "week.json")}
  end

  def render("week.json", %{week: week}) do
    %{id: week.id,
      is_open: week.is_open}
  end
end
