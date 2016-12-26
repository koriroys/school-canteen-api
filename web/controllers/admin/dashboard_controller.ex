defmodule SchoolCanteen.Admin.DashboardController do
  use SchoolCanteen.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
