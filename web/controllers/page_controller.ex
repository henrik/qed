defmodule QED.PageController do
  use QED.Web, :controller

  def index(conn, params) do
    code = params["code"]

    render conn, "index.html",
      invalid_code?: invalid_code?(code),
      code: code,
      meta: params["meta"] == "true"
  end

  defp invalid_code?(code) do
    case Code.string_to_quoted(code) do
      {:ok, _} -> false
      {:error, _} -> true
    end
  end
end
