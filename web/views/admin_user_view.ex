defmodule SchoolCanteen.AdminUserView do
  use SchoolCanteen.Web, :view

  def render("index.json", %{admin_users: admin_users}) do
    %{data: render_many(admin_users, SchoolCanteen.AdminUserView, "admin_user.json")}
  end

  def render("show.json", %{admin_user: admin_user}) do
    %{data: render_one(admin_user, SchoolCanteen.AdminUserView, "admin_user.json")}
  end

  def render("admin_user.json", %{admin_user: admin_user}) do
    %{
      "type": "admin-user",
      "id": admin_user.id,
      "attributes": %{
        "email": admin_user.email
      }
    }
  end
end