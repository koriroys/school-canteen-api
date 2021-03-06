defmodule SchoolCanteen.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias SchoolCanteen.Repo
  alias SchoolCanteen.User
  alias SchoolCanteen.AdminUser

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(admin = %AdminUser{}), do: { :ok, "AdminUser:#{admin.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Repo.get(User, id) }
  def from_token("AdminUser:" <> id), do: { :ok, Repo.get(AdminUser, id) }
  def from_token(_), do: { :error, "Unknown resource type" }
end