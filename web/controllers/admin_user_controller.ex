require IEx

defmodule SchoolCanteen.AdminUserController do
  use SchoolCanteen.Web, :controller

  alias SchoolCanteen.AdminUser
  plug Guardian.Plug.EnsureAuthenticated, handler: SchoolCanteen.AuthErrorHandler

  def current(conn, _) do
    admin_user = conn
    |> Guardian.Plug.current_resource

    case admin_user do
      %AdminUser{} ->
        conn
        |> render(SchoolCanteen.AdminUserView, "show.json", admin_user: admin_user)
      _ ->
        conn
        |> put_status(403)
        |> render(SchoolCanteen.ErrorView, "403.json")
    end
  end
end