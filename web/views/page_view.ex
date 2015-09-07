defmodule QED.PageView do
  use QED.Web, :view

  def visualization(code, include_meta) do
    raw QED.PageView.Visualizer.html(code, include_meta)
  end

  def quoted(code) do
    inspect Code.string_to_quoted!(code)
  end

  def example_code do
    """
    if true, do: IO.puts("Hello!")
    """
  end
end
