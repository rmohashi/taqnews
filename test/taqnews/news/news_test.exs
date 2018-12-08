defmodule Taqnews.NewsTest do
  use Taqnews.DataCase

  alias Taqnews.News

  describe "weeks" do
    alias Taqnews.News.Week

    @valid_attrs %{is_open: true}
    @update_attrs %{is_open: false}
    @invalid_attrs %{is_open: nil}

    def week_fixture(attrs \\ %{}) do
      {:ok, week} =
        attrs
        |> Enum.into(@valid_attrs)
        |> News.create_week()

      week
    end

    test "list_weeks/0 returns all weeks" do
      week = week_fixture()
      assert News.list_weeks() == [week]
    end

    test "get_week!/1 returns the week with given id" do
      week = week_fixture()
      assert News.get_week!(week.id) == week
    end

    test "create_week/1 with valid data creates a week" do
      assert {:ok, %Week{} = week} = News.create_week(@valid_attrs)
      assert week.is_open == true
    end

    test "create_week/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = News.create_week(@invalid_attrs)
    end

    test "update_week/2 with valid data updates the week" do
      week = week_fixture()
      assert {:ok, %Week{} = week} = News.update_week(week, @update_attrs)
      assert week.is_open == false
    end

    test "update_week/2 with invalid data returns error changeset" do
      week = week_fixture()
      assert {:error, %Ecto.Changeset{}} = News.update_week(week, @invalid_attrs)
      assert week == News.get_week!(week.id)
    end

    test "delete_week/1 deletes the week" do
      week = week_fixture()
      assert {:ok, %Week{}} = News.delete_week(week)
      assert_raise Ecto.NoResultsError, fn -> News.get_week!(week.id) end
    end

    test "change_week/1 returns a week changeset" do
      week = week_fixture()
      assert %Ecto.Changeset{} = News.change_week(week)
    end
  end
end
