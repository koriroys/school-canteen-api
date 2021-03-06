defmodule SchoolCanteen.UserView do
  use SchoolCanteen.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, SchoolCanteen.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, SchoolCanteen.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      "type": "user",
      "id": user.id,
      "attributes": %{
        "email": user.email
      }
    }
  end
end