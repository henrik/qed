defmodule QED.PageView do
  use QED.Web, :view

  # TODO: Where does this belong? Make sure Phoenix reloads the page when it changes.
  defmodule Visualizer do
    def html(code) do
      quoted = Code.string_to_quoted!(code)
      _render(quoted)
    end

    defp _render({name, meta, args}) do
      """
        <div class="vis-tuple">
          <div><b>NAME:</b> #{_render name}</div>
          <div class="vis-meta"><b>META:</b> #{_render meta}</div>
          <div><b>ARGS:</b> #{_render args}</div>
        </div>
      """
    end

    defp _render(list) when is_list(list) do
      cond do
        keyword?(list) -> render_keyword_list(list)
        true -> render_non_keyword_list(list)
      end
    end

    defp _render(other) do
      other |> inspect |> h
    end

    defp render_non_keyword_list(list) do
      items = list |> Enum.map fn (item) ->
        """
          <div class="vis-list-item">
            #{_render item}
            <b class="vis-list-comma">,</b>
          </div>
        """
      end

      """
        <div class="vis-list">
          <b>[</b>
          #{items}
          <b>]</b>
        </div>
      """
    end

    defp render_keyword_list(list) do
      items = list |> Enum.map fn ({key, value}) ->
        """
          <div class="vis-list-item">
            <i>#{h key}:</i> #{_render value}
            <b class="vis-list-comma">,</b>
          </div>
        """
      end

      """
        <div class="vis-list">
          <b>[</b>
          #{items}
          <b>]</b>
        </div>
      """
    end

    # Stolen from https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/inspect.ex

    defp keyword?([{key, _value} | rest]) when is_atom(key) do
      case Atom.to_char_list(key) do
        'Elixir.' ++ _ -> false
        _ -> keyword?(rest)
      end
    end

    defp keyword?([]),     do: true
    defp keyword?(_other), do: false

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
