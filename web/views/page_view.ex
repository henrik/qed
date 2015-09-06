defmodule QED.PageView do
  use QED.Web, :view

  # FIXME: Make HTML valid. We're mixing spans and divs willy nilly.
  # TODO: Where does this belong? Make sure Phoenix reloads the page when it changes.
  # Reference: http://elixir-lang.org/getting-started/meta/quote-and-unquote.html
  defmodule Visualizer do
    def html(code, include_meta) do
      quoted = Code.string_to_quoted!(code)

      class = case include_meta do
        true -> "vis"
        false -> "vis vis--no-meta"
      end

      """
      <div class="#{class}">
        #{_render(quoted)}
      </div>
      """
    end

    defp _render({name, meta, args_or_atom}) do
      last_label =
        case args_or_atom do
        x when is_list(x) -> "Args:"
        _ -> "Atom:"
        end

      """
        <div class="vis-tuple">
          <div>
            <span class="vis-label">Name:</span>
            #{_render name}
          </div>
          <div class="vis-meta">
            <span class="vis-label">Meta:</span>
            <span class="vis-meta-content">#{_render meta}</span>
          </div>
          <div><span class="vis-label">#{last_label}</span> #{_render args_or_atom}</div>
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
          </div>
          <b class="vis-list-comma">,</b>
        """
      end

      """
        <div class="vis-list">
          <span class="vis-list-paren">[</span>
          <span class="vis-list-items">
            #{items}
          </span>
          <span class="vis-list-paren">]</span>
        </div>
      """
    end

    defp render_keyword_list(list) do
      items = list |> Enum.map fn ({key, value}) ->
        """
          <div class="vis-list-item">
            <i>#{h key}:</i> #{_render value}
          </div>
          <span class="vis-list-comma">,</span>
        """
      end

      """
        <div class="vis-list">
          <span class="vis-list-paren">[</span>
          <span class="vis-list-items">
            #{items}
          </span>
          <span class="vis-list-paren">]</span>
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

  def visualization(code, include_meta) do
    raw Visualizer.html(code, include_meta)
  end

  def quoted(code) do
    inspect Code.string_to_quoted!(code)
  end

  def example_code do
    """
    IO.puts("Hello <b>bold</b> world!")
    """
  end
end
