defmodule SchoolCanteen.Admin.MonthController do
  use SchoolCanteen.Web, :controller
  import Ecto.Query, only: [from: 2]

  alias SchoolCanteen.Month

  # if searching by "start_day"
  def index(conn, params = %{"start_day" => start_day}) do
    # change = Ecto.Changeset.cast(%Month{}, params, [:start_day])
    # example start_day: "Sun Jan 01 2017 00:00:00 GMT+0100 (CET)"
    {:ok, parsed_start_day} = Timex.parse(start_day, "%a %b %d %Y %H:%M:%S %Z%z (%Z)", :strftime)
    query = from m in Month,
            where: m.start_day == ^parsed_start_day
    case Repo.one(query) do
      month ->
        render(conn, "show.json", month: month)
      nil ->
        render(SchoolCanteen.ErrorView, "404.json")
    end
  end

  def index(conn, params) do

    months = Repo.all(Month)
    render(conn, "index.json", months: months)
  end

  def create(conn, %{"month" => month_params}) do
    changeset = Month.changeset(%Month{}, month_params)

    case Repo.insert(changeset) do
      {:ok, month} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", month_path(conn, :show, month))
        |> render("show.json", month: month)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SchoolCanteen.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    month = Repo.get!(Month, id)
    render(conn, "show.json", month: month)
  end

  def update(conn, %{"id" => id, "month" => month_params}) do
    month = Repo.get!(Month, id)
    changeset = Month.changeset(month, month_params)

    case Repo.update(changeset) do
      {:ok, month} ->
        render(conn, "show.json", month: month)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SchoolCanteen.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    month = Repo.get!(Month, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(month)

    send_resp(conn, :no_content, "")
  end
end
