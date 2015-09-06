defmodule QED.PageView do
  use QED.Web, :view

  # TODO: Where does this belong? Make sure Phoenix reloads the page when it changes.
  defmodule Visualizer do
    def html(code) do
      "<p><i>TODOs:</i> #{h code}</p>"
    end

    defp h(unsafe_html) do
      unsafe_html |> html_escape |> safe_to_string
    end
  end

  def visualization(code) do
    raw Visualizer.html(code)
  end

  def quoted(code) do
    inspect Code.string_to_quoted!(code)
  end
end
