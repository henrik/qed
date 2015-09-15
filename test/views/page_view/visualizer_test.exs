defmodule QED.PageViewVisualizerTest do
  use QED.ConnCase, async: true

  # These tests are not very detailed. The idea is to catch any major errors, and leave the rest to manual, visual testing.

  test "it adds 'vis--no-meta' if told to exclude meta" do
    output = QED.PageView.Visualizer.html("1+2", include_meta?: false)
    assert output =~ "vis--no-meta"

    output = QED.PageView.Visualizer.html("1+2", include_meta?: true)
    refute output =~ "vis--no-meta"
  end

  test "it handles Args" do
    assert QED.PageView.Visualizer.html("foo(1)") =~ "Args:"
  end

  test "it handles Atoms" do
    assert QED.PageView.Visualizer.html("x") =~ "Atom:"
  end

  test "it handles keyword lists" do
    assert QED.PageView.Visualizer.html("[a: b]") =~ "<i>a:</i>"
  end

  test "it handles non-keyword lists" do
    assert QED.PageView.Visualizer.html("[1]") =~ "1"
  end

  test "it links :__aliases__ to more info" do
    assert QED.PageView.Visualizer.html("IO.puts 1") =~ "SpecialForms.html#__aliases__/1"
  end

  test "it links :. to more info" do
    assert QED.PageView.Visualizer.html("IO.puts 1") =~ "SpecialForms.html#./2"
  end
end
