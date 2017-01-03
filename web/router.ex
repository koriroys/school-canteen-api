defmodule SchoolCanteen.Router do
  use SchoolCanteen.Web, :router
  import SchoolCanteen.Plugs.Authorize

  # Unauthenticated Requests
  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  # Authenticated Requests
  pipeline :api_user do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, serializer: SchoolCanteen.Serializers.GuardianUserSerializer
    plug Guardian.Plug.EnsureResource, handler: SchoolCanteen.AuthErrorHandler
    plug SchoolCanteen.Plugs.Authorize, %{ key: :user, user_type: %SchoolCanteen.User{} }
  end

  pipeline :api_admin do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, serializer: SchoolCanteen.Serializers.GuardianAdminSerializer
    plug Guardian.Plug.EnsureResource, handler: SchoolCanteen.AuthErrorHandler
    plug SchoolCanteen.Plugs.Authorize, %{ key: :admin_user, user_type: %SchoolCanteen.AdminUser{} }
  end

  scope "/api", SchoolCanteen do
    pipe_through :api

    post "/register", RegistrationController, :create

    post "/token", SessionController, :create, as: :login
    post "/admin/token", Admin.SessionController, :create, as: :login_admin
  end

  scope "/api", SchoolCanteen do
    pipe_through :api_user
    get "/user/current", UserController, :current
  end

  scope "/api", SchoolCanteen do
    pipe_through :api_admin
    get "/admin_user/current", AdminUserController, :current
  end

  scope "/api/admin", SchoolCanteen.Admin do
    resources "/months", MonthController, except: [:new, :edit]
  end
end
