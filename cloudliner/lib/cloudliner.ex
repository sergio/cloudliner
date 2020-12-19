defmodule Cloudliner do
  def main(_args \\ []) do

    IO.read(:stdio, :all)
    |> Opml.parse()
    |> Outline.yaml()
    |> Enum.each(&IO.puts/1)

  end

end
