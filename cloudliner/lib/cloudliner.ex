defmodule Cloudliner do
  def main(args \\ []) do

    opts = OptionParser.parse!(args, strict: [inform: :string])

    case opts do
      {[inform: "opml"], _} -> opml_to_yaml()
      {[inform: "yaml"], _} -> yaml_to_opml()
      _ -> IO.puts("Usage: cloudliner --inform [opml|yaml]")
    end

  end

  def opml_to_yaml() do
    IO.read(:stdio, :all)
    |> Opml.parse()
    |> Outline.yaml()
    |> Enum.each(&IO.puts/1)
  end

  def yaml_to_opml() do
    IO.read(:stdio, :all)
    |> YamlImporter.convert_to_opml()
    |> IO.puts()
  end

end
