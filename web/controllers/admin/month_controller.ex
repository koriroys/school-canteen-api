defmodule SchoolCanteen.Admin.MonthController do
  use SchoolCanteen.Web, :controller

  alias SchoolCanteen.Month

  def index(conn, _params) do
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
