defmodule LoverageWeb.ViewHelpers do

  def auto_ellipsis(content) do
    sliced = content |> String.slice(0, 29)
    sliced <> "…"
  end
end
