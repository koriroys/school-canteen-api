defmodule SchoolCanteen.Router do
  use SchoolCanteen.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/api", SchoolCanteen do
    pipe_through :api

    post "/register", RegistrationController, :create

    resources "/session", SessionController, only: [:index]
  end
end
