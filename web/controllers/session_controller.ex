defmodule SchoolCanteen.SessionController do
  use SchoolCanteen.Web, :controller

  def index(conn, _params) do
    conn
    |> json(%{status: "OK"})
  end
end