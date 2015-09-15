defmodule QED.PageViewTest do
  use QED.ConnCase, async: true

  test "quoted" do
    assert QED.PageView.quoted("1+2") == "{:+, [line: 1], [1, 2]}"
  end

  # Just testing integration. Details can be tested inside Visualizer.
  test "visualization" do
    {:safe, html} = QED.PageView.visualization("1+2", include_meta?: true)
    assert html =~ ":+"
  end
end
