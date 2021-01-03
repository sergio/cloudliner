defmodule YamlImporter do
  def convert_to_opml(yaml) do
    yaml
    |> isolate_list_item_dashes()
    |> split_lines()
    |> remove_empty_lines()
    |> calculate_indent_sizes()
    |> Tree.make_from_nodes(fn {indent1, _}, {indent2, _} -> indent1 < indent2 end)
    |> reduce_to_xml_elements()
    |> wrap_in_opml()
    |> Exoml.encode()
  end

  defp wrap_in_opml(outline_elements) do
    {:root, [], [
      {"opml", [{"version", "2.0"}], [
        {"head", [], []},
        {"body", [], outline_elements}
      ]}
    ]}
  end

  defp reduce_to_xml_elements([]), do: nil

  defp reduce_to_xml_elements(nodes) do
    nodes
    |> Enum.map(fn node = %Tree.Node{value: {_, text}} -> {"outline", [{"text", text}, {"_status", "checked"}], reduce_to_xml_elements(node.children)} end)
  end

  defp calculate_indent_sizes(lines) do
    lines |> Enum.map(fn line -> {leading_spaces(line), String.trim(line)} end)
  end

  defp split_lines(text) do
    text |> String.split(~r{\r\n|\r|\n})
  end

  defp remove_empty_lines(lines) do
    lines |> Enum.filter(fn line -> line != "" end)
  end

  defp leading_spaces(line) do
    line
    |> String.graphemes()
    |> Enum.take_while(fn c -> c == " " end)
    |> Enum.count()
  end

  defp isolate_list_item_dashes(text) do
    # If needed, add a new line after dashes ('-') which represent list items,
    # so they will act as containers for the following non-dashed lines
    # once converted to opml.
    Regex.replace(~r/^((\s+)-)/m, text, "\\1\n\\2 ")
  end

end
