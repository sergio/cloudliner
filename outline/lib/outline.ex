defmodule Outline do

  def yaml(input) do
    render(input, _indent_level = 0)
  end

  defp render([], _level), do: []

  defp render([head], level) do
    render(head, level)
  end

  defp render([head|tail], level) do
    render(head, level) ++ render(tail, level)
  end

  defp render({label}, level) do
    render({label, []}, level)
  end
 
  defp render({label, []}, level) do
    ["#{indent(level)}#{label}"]
  end

  defp render({label, contents}, level) do
    ["#{indent(level)}#{label}:"] ++ render(contents, level + 1)
  end

  defp indent(level) do
    String.duplicate("  ", level)
  end
  
end
