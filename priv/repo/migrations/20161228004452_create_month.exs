defmodule SchoolCanteen.Repo.Migrations.CreateMonth do
  use Ecto.Migration

  def change do
    create table(:months) do
      add :start_day, :date

      timestamps()
    end

  end
end
