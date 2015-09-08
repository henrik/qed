defmodule QED.PageViewVisualizerTest do
  use QED.ConnCase, async: true

  test "it adds 'vis--no-meta' if told to exclude meta" do
    output = QED.PageView.Visualizer.html("1+2", false)
    assert String.contains? output, "vis--no-meta"

    output = QED.PageView.Visualizer.html("1+2", true)
    refute String.contains? output, "vis--no-meta"
  end
end
