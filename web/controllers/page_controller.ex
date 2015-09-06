defmodule QED.PageController do
  use QED.Web, :controller

  def index(conn, params) do
    code = params["code"]
    quoted = inspect Code.string_to_quoted!(code)

    render conn, "index.html",
      code: code,
      quoted: quoted
  end
end
