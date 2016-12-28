defmodule SchoolCanteen.MonthTest do
  use SchoolCanteen.ModelCase

  alias SchoolCanteen.Month

  @valid_attrs %{start_day: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Month.changeset(%Month{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Month.changeset(%Month{}, @invalid_attrs)
    refute changeset.valid?
  end
end
