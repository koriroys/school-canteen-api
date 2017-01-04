defmodule SchoolCanteen.Plugs.Authorize do
  import Plug.Conn
  import Phoenix.View

  def init(options), do: options

  def call(conn, options) do
    user_type = options[:user_type]
    resource = conn |> Guardian.Plug.current_resource
    case resource do
      user_type ->
        assign(conn, options[:key], resource)
    end
  end
  def call(conn, _options), do: conn
end