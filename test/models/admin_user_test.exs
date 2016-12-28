defmodule SchoolCanteen.AdminUserTest do
  use SchoolCanteen.ModelCase

  alias SchoolCanteen.AdminUser

  @valid_attrs %{email: "admin@example.com", password: "password", password_confirmation: "password"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AdminUser.changeset(%AdminUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
