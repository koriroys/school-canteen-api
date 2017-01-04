defmodule SchoolCanteen.UserController do
  use SchoolCanteen.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: SchoolCanteen.AuthErrorHandler

  def current(conn, _) do
    conn
    |> render(SchoolCanteen.UserView, "show.json", user: conn.assigns.user)
  end
end