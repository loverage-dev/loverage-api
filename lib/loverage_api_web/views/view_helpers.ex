defmodule LoverageWeb.ViewHelpers do

  def auto_ellipsis(content) do
    sliced = content |> String.slice(0, 29)
    sliced <> "…"
  end

  def sunitize_html(content) do
    sunitized = content |> String.replace(~r/<("[^"]*"|'[^']*'|[^'">])*>/,"")
  end
end
