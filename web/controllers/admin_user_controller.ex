defmodule SchoolCanteen.AdminUserController do
  use SchoolCanteen.Web, :controller

  alias SchoolCanteen.AdminUser
  plug Guardian.Plug.EnsureAuthenticated, handler: SchoolCanteen.AuthErrorHandler

  def current(conn, _) do
    conn
    |> render(SchoolCanteen.AdminUserView, "show.json", admin_user: conn.assigns.admin_user)
  end

end