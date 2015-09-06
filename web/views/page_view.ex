defmodule QED.PageView do
  use QED.Web, :view

  def quoted(code) do
    inspect Code.string_to_quoted!(code)
  end
end
