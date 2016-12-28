defmodule SchoolCanteen.Month do
  use SchoolCanteen.Web, :model

  schema "months" do
    field :start_day, Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:start_day])
    |> validate_required([:start_day])
  end
end
