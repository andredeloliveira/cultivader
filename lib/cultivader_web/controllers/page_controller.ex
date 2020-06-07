defmodule CultivaderWeb.PageController do
  use CultivaderWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
