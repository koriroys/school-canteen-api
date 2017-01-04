defmodule SchoolCanteen.Admin.MonthView do
  use SchoolCanteen.Web, :view

  def render("index.json", %{months: months}) do
    %{data: render_many(months, SchoolCanteen.Admin.MonthView, "month.json")}
  end

  def render("show.json", %{month: month}) do
    %{data: render_one(month, SchoolCanteen.Admin.MonthView, "month.json")}
  end

  def render("month.json", %{month: month}) do
    %{
      type: "month",
      id: month.id,
      attributes: %{
        "start-day": month.start_day
      }
    }
  end
end
