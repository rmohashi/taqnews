defmodule TaqnewsWeb.WeekControllerTest do
  use TaqnewsWeb.ConnCase

  alias Taqnews.News
  alias Taqnews.News.Week

  @create_attrs %{
    is_open: true
  }
  @update_attrs %{
    is_open: false
  }
  @invalid_attrs %{is_open: nil}

  def fixture(:week) do
    {:ok, week} = News.create_week(@create_attrs)
    week
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all weeks", %{conn: conn} do
      conn = get(conn, Routes.week_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create week" do
    test "renders week when data is valid", %{conn: conn} do
      conn = post(conn, Routes.week_path(conn, :create), week: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.week_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_open" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.week_path(conn, :create), week: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update week" do
    setup [:create_week]

    test "renders week when data is valid", %{conn: conn, week: %Week{id: id} = week} do
      conn = put(conn, Routes.week_path(conn, :update, week), week: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.week_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_open" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, week: week} do
      conn = put(conn, Routes.week_path(conn, :update, week), week: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete week" do
    setup [:create_week]

    test "deletes chosen week", %{conn: conn, week: week} do
      conn = delete(conn, Routes.week_path(conn, :delete, week))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.week_path(conn, :show, week))
      end
    end
  end

  defp create_week(_) do
    week = fixture(:week)
    {:ok, week: week}
  end
end
