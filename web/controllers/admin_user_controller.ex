require IEx

defmodule SchoolCanteen.AdminUserController do
  use SchoolCanteen.Web, :controller

  alias SchoolCanteen.AdminUser
  plug Guardian.Plug.EnsureAuthenticated, handler: SchoolCanteen.AuthErrorHandler

  def current(conn, _) do
    admin_user = conn
    |> Guardian.Plug.current_resource

    if is_admin(admin_user) do
      conn
      |> render(SchoolCanteen.AdminUserView, "show.json", admin_user: admin_user)
    else
      conn
      |> put_status(403)
      |> render(SchoolCanteen.ErrorView, "403.json")
    end
  end

  def is_admin(%AdminUser{}), do: true
  def is_admin(_), do: false
end