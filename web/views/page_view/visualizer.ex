# FIXME: Make HTML valid. We're mixing spans and divs willy nilly.
# Reference: http://elixir-lang.org/getting-started/meta/quote-and-unquote.html
defmodule QED.PageView.Visualizer do
  use QED.Web, :view

  @doc_version "1.0"

  def html(code), do: html(code, include_meta?: true)

  def html(code, include_meta?: include_meta?) do
    quoted = Code.string_to_quoted!(code)

    class = case include_meta? do
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
          #{render_name name}
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
      Keyword.keyword?(list) -> render_list(list |> Enum.map fn ({key, value}) -> "<i>#{h key}:</i> #{_render value}" end)
      true                   -> render_list(list |> Enum.map fn (item) -> _render(item) end)
    end
  end

  defp _render(other) do
    other |> inspect |> h
  end

  defp render_name(name = :__aliases__), do: "<a href=\"http://elixir-lang.org/docs/v#{@doc_version}/elixir/Kernel.SpecialForms.html#__aliases__/1\" class=\"doc-link\">#{inspect name}</a>"
  defp render_name(name = :.), do:           "<a href=\"http://elixir-lang.org/docs/v#{@doc_version}/elixir/Kernel.SpecialForms.html#./2\" class=\"doc-link\">#{inspect name}</a>"
  defp render_name(name), do: _render(name)

  defp render_list(list) do
    items = list |> Enum.map fn (item) ->
      """
        <div class="vis-list-item">
          #{item}
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

  defp h(unsafe_html) do
    unsafe_html |> html_escape |> safe_to_string
  end
end
