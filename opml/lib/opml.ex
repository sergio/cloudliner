defmodule Opml do

  import SweetXml, only: [sigil_x: 2]

  def parse(opml) do
    opml
    |> SweetXml.xpath(~x[/opml/body/outline]l)
    |> parse_elements()
  end

  defp parse_elements(outline_elems) do
    outline_elems
    |> Enum.filter(fn e -> SweetXml.xpath(e, ~x[./@_status]o) != nil end)
    |> Enum.map(fn e ->
        fields = SweetXml.xmap(e, [text: ~x[./@text]s, note: ~x[./@_note]s, children: ~x[./outline]l])
        assemble(fields.text, fields.note, parse_elements(fields.children))
    end)
  end

  defp assemble(text, "", []), do: {text}
  defp assemble(text, "", contents), do: {text, contents}
  defp assemble(text, note, contents), do: {text, [{note} | contents]}

end
