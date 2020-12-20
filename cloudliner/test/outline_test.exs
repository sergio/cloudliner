defmodule OutlineTest do
  use ExUnit.Case

  test "render" do

    test_cases = [
      {
        "empty input yields empty output",
        [],
        [],
      },
      {
        "single node",
        [{"1"}],
        ["1"],
      },
      {
        "several nodes at the same level",
        [{"1"}, {"2"}],
        ["1", "2"],
      },
      {
        "nested one level",
        [{"1", [{"1.1"}]}, {"2"}],
        ["1:", "  1.1", "2"],
      },
      {
        "nested two levels",
        [{"1", [{"1.1", [{"1.1.1"}]}]}, {"2", [{"2.1"}]}],
        ["1:", "  1.1:", "    1.1.1", "2:", "  2.1"],
      },
      {
        "array element indicator '-' does not end with ':'",
        [{"MyArray", [{"-", [{"one"},{"two"}]}]}],
        ["MyArray:", "  -", "    one", "    two"],
      }
    ]

    for {_title, input, expected} <- test_cases do
      assert Outline.yaml(input) == expected
    end

  end

end
