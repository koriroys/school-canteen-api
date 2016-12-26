defmodule SchoolCanteen.Repo.Migrations.CreateAdminUser do
  use Ecto.Migration

  def change do
    create table(:admin_users) do
      add :email, :string
      add :password_hash, :string

      timestamps()
    end
    create index(:admin_users, [:email], unique: true)
  end
end
