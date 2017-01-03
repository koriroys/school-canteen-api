defmodule SchoolCanteen.AuthErrorHandler do
  use SchoolCanteen.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(SchoolCanteen.ErrorView, "401.json")
  end

  def unauthorized(conn, _params) do
    conn
    |> put_status(403)
    |> render(SchoolCanteen.ErrorView, "403.json")
  end

  def no_resource(conn, _params) do
    conn
    |> put_status(404)
    |> render(SchoolCanteen.ErrorView, "404.json")
  end
end