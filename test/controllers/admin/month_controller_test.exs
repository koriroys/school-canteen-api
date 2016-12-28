defmodule SchoolCanteen.Admin.MonthControllerTest do
  use SchoolCanteen.ConnCase

  alias SchoolCanteen.Month
  @valid_attrs %{start_day: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, month_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    month = Repo.insert! %Month{}
    conn = get conn, month_path(conn, :show, month)
    assert json_response(conn, 200)["data"] == %{"id" => month.id,
      "start_day" => month.start_day}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, month_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, month_path(conn, :create), month: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Month, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, month_path(conn, :create), month: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    month = Repo.insert! %Month{}
    conn = put conn, month_path(conn, :update, month), month: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Month, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    month = Repo.insert! %Month{}
    conn = put conn, month_path(conn, :update, month), month: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    month = Repo.insert! %Month{}
    conn = delete conn, month_path(conn, :delete, month)
    assert response(conn, 204)
    refute Repo.get(Month, month.id)
  end
end
