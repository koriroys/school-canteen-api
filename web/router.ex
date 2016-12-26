defmodule SchoolCanteen.Router do
  use SchoolCanteen.Web, :router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

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

  scope "/admin", SchoolCanteen do
    pipe_through :browser
    get "/", Admin.DashboardController, :index
  end
end
