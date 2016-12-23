defmodule SchoolCanteen.Router do
  use SchoolCanteen.Web, :router

  # Unauthenticated Requests
  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  # Authenticated Requests
  pipeline :api_auth do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", SchoolCanteen do
    pipe_through :api

    post "/register", RegistrationController, :create

    post "/token", SessionController, :create, as: :login
  end

  scope "/api", SchoolCanteen do
    pipe_through :api_auth
    get "/user/current", UserController, :current
  end
end
