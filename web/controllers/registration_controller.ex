defmodule SchoolCanteen.RegistrationController do
  use SchoolCanteen.Web, :controller

  alias SchoolCanteen.User

  def create(conn, %{"data" => %{"type" => "users",
    "attributes" => %{"email" => email,
      "password" => password,
      "password-confirmation" => password_confirmation}}}) do

    changeset = User.changeset(%User{}, %{email: email,
      password: password,
      password_confirmation: password_confirmation})

    case Repo.insert changeset do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(SchoolCanteen.UserView, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SchoolCanteen.ChangesetView, "error.json", changeset: changeset)
    end
  end
end