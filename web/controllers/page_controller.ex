defmodule QED.PageController do
  use QED.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
