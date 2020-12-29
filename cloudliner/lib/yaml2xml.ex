defmodule YamlToXml do

  def convert_to_opml(yaml) do
    yaml
    |> YamlElixir.read_from_string()
    |> transform_to_opml_elements()
    |> encode_to_xml()
  end

  defp encode_to_xml(dom_element_list) do
    Exoml.encode({:root, [], dom_element_list})
  end

  defp transform_to_opml_elements({:ok, yaml_node}) do
      [yaml_node_to_outline_dom(yaml_node)]
  end

  defp transform_to_opml_elements({:error, error_message}) do
    IO.puts(error_message)
    exit(:error)
  end

  defp yaml_node_to_outline_dom(dict = %{}) do
    dict |> Enum.map(fn {k,v} ->
      {"outline", [{"text", k}], yaml_node_to_outline_dom(v)}
    end)
  end

  defp yaml_node_to_outline_dom([]), do: []

  defp yaml_node_to_outline_dom([head | tail]) do
    [yaml_node_to_outline_dom(head) | yaml_node_to_outline_dom(tail)]
  end

  defp yaml_node_to_outline_dom(primitive) do
    {"outline", [{"text", primitive}], nil}
  end

end
