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
    post "/admin/token", Admin.SessionController, :create, as: :login_admin
  end

  scope "/api", SchoolCanteen do
    pipe_through :api_auth
    get "/user/current", UserController, :current
    get "/admin_user/current", AdminUserController, :current
  end

  scope "/api/admin", SchoolCanteen.Admin do
    resources "/months", MonthController, except: [:new, :edit]
  end
end
