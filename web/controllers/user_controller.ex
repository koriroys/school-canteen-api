defmodule SchoolCanteen.UserController do
  use SchoolCanteen.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: SchoolCanteen.AuthErrorHandler

  def current(conn, _) do
    user = conn
    |> Guardian.Plug.current_resource

    conn
    |> render(SchoolCanteen.UserView, "show.json", user: user)
  end
end