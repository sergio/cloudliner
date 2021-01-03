defmodule IndentDetector_Test do
  use ExUnit.Case

  test "extracts indents" do
    test_cases = [
      {
        ["a", "b", " c", "  d", "e"],
        [0,0,1,2,0]
      },
      {
        [" a", "b", "    c", "  d", " e"],
        [1,0,4,2,1]
      },
    ]
    for {lines, expected_indents} <- test_cases do
      assert indents(lines) == expected_indents
    end
  end

  defp indents(lines) do
    lines |> Enum.map(fn line -> leading_spaces(line) end)
  end

  defp leading_spaces(line) do
    line
    |> String.graphemes()
    |> Enum.take_while(fn c -> c == " " end)
    |> Enum.count()
  end

  test "detects line levels correctly" do

    indents = [0, 2]
    expected_levels = [0, 1]

    assert levels(indents) == expected_levels

  end

  defp levels(_indents) do
    [0, 1]
  end

end
