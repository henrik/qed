defmodule QED.PageViewVisualizerTest do
  use QED.ConnCase, async: true

  # These tests are not very detailed. The idea is to catch any major errors, and leave the rest to manual, visual testing.

  test "it adds 'vis--no-meta' if told to exclude meta" do
    output = QED.PageView.Visualizer.html("1+2", false)
    assert String.contains? output, "vis--no-meta"

    output = QED.PageView.Visualizer.html("1+2", true)
    refute String.contains? output, "vis--no-meta"
  end

  test "it handles Args" do
    output = QED.PageView.Visualizer.html("foo(1)", true)
    assert String.contains? output, "Args:"
  end

  test "it handles Atoms" do
    output = QED.PageView.Visualizer.html("x", true)
    assert String.contains? output, "Atom:"
  end

  test "it handles keyword lists" do
    output = QED.PageView.Visualizer.html("[a: b]", true)
    assert String.contains? output, "<i>a:</i>"
  end

  test "it handles non-keyword lists" do
    output = QED.PageView.Visualizer.html("[1]", true)
    assert String.contains? output, "1"
  end

  test "it links :__aliases__ to more info" do
    output = QED.PageView.Visualizer.html("IO.puts 1", true)
    assert String.contains? output, "SpecialForms.html#__aliases__/1"
  end

  test "it links :. to more info" do
    output = QED.PageView.Visualizer.html("IO.puts 1", true)
    assert String.contains? output, "SpecialForms.html#./2"
  end
end
