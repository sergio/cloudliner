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

  defp render({label, nonempty_contents}, level) do
    ["#{indent(level)}#{format_as_container(label)}"] ++ render(nonempty_contents, level + 1)
  end

  defp format_as_container("-"), do: "-"
  defp format_as_container(label) do
    # If ends with '|' (yaml multiline starter)
    # or if it ends with ':' already, return unaltered.
    if String.match?(label, ~r"[:\|]\s+$") do
      label
    else
      "#{label}:"
    end
  end

  defp indent(level) do
    String.duplicate("  ", level)
  end

end
