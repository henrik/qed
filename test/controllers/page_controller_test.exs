defmodule QED.PageControllerTest do
  use QED.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Quoted Expression Demonstrator"
  end
end
