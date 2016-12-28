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
      user = AdminUser
      |> where(email: ^username)
      |> Repo.one!
      cond do

        checkpw(password, user.password_hash) ->
          # Login Success
          Logger.info "Admin " <> username <> " just logged in"
        {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)
        conn
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