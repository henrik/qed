defmodule QEDWeb.PageControllerTest do
  use QEDWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Quoted Expression Demonstrator"
  end

  test "GET / with code and meta flag", %{conn: conn} do
    conn = get(conn, "/?code=1-2&meta=true")
    response = html_response(conn, 200)

    # Code
    assert response =~ "1-2"

    # Quoted
    assert response =~ "[1, 2]"
  end

  test "GET / with unparsable code", %{conn: conn} do
    conn = get(conn, "/?code=-")
    response = html_response(conn, 200)

    assert response =~ "doesn't parse"
  end
end
