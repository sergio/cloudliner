defmodule ImportTest do
  use ExUnit.Case

  test "yaml to opml xml conversion" do

    test_cases = [
      {
        """
        a
        """,
        {:root, [], [{"outline", [{"text", "a"}], nil}]}
      },
      {
        """
        a:
          b
        """,
        {:root, [], [
          {"outline", [{"text", "a"}], [
            {"outline", [{"text", "b"}], nil}
          ]},
        ]}
      },
      {
        """
        a:
          b:
            - one
            - two
        """,
        {:root, [], [
          {"outline", [{"text", "a"}], [
            {"outline", [{"text", "b"}], [
              {"outline", [{"text", "one"}], nil},
              {"outline", [{"text", "two"}], nil}
            ]}
          ]},
        ]}
      },
    ]

    for {yaml, expected_dom} <- test_cases do
      assert dom(YamlToXml.convert_to_opml(yaml)) == expected_dom
    end
  end

  def dom(xmlstr) do
    Exoml.decode(xmlstr)
  end

end
