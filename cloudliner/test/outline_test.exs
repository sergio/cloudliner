defmodule OutlineTest do
  use ExUnit.Case

  test "render" do

    test_cases = [
      {
        [],
        []
      },
      {
        [{"1"}],
        ["1"]
      },
      {
        [{"1"}, {"2"}],
        ["1", "2"]
      },
      {
        [{"1", [{"1.1"}]}, {"2"}],
        ["1:", "  1.1", "2"]
      },
      {
        [{"1", [{"1.1", [{"1.1.1"}]}]}, {"2", [{"2.1"}]}],
        ["1:", "  1.1:", "    1.1.1", "2:", "  2.1"]
      },
    ]

    for {input, expected} <- test_cases do
      assert Outline.yaml(input) == expected
    end

  end

end
