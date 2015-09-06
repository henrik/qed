defmodule QED.PageController do
  use QED.Web, :controller

  def index(conn, params) do
    render conn, "index.html", code: params["code"]
  end
end
