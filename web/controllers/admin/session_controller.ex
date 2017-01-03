defmodule SchoolCanteen.Admin.SessionController do
  use SchoolCanteen.Web, :controller

  import Ecto.Query, only: [where: 2]
  import Comeonin.Bcrypt
  require Logger

  alias SchoolCanteen.AdminUser

  def create(conn, %{"grant_type" => "password",
    "username" => username,
    "password" => password}) do

    try do
      admin = AdminUser
      |> where(email: ^username)
      |> Repo.one!
      cond do

        checkpw(password, admin.password_hash) ->
          # Login Success
          Logger.info "Admin " <> username <> " just logged in"
          new_conn = Guardian.Plug.api_sign_in(conn, admin)
          jwt = Guardian.Plug.current_token(new_conn)
          new_conn
          |> json(%{access_token: jwt}) # return token to client

        true ->
          # Login Failed
          Logger.warn "Admin " <> username <> " failed to login"
          conn
          |> put_status(401)
          |> render(SchoolCanteen.ErrorView, "401.json")
      end
    rescue
      e ->
        IO.inspect e
        Logger.error "Unexpected error while attempting to login admin " <> username
        conn
        |> put_status(401)
        |> render(SchoolCanteen.ErrorView, "401.json")
    end

  end

  def create(_, %{"grant_type" => _}) do
    ## handle unknown grant type
    throw "Unsupported grant_type"
  end
end