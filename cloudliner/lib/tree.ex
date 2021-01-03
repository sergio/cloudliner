defmodule Tree do

  def make_from_nodes([], _), do: []

  def make_from_nodes(values, comparer) do
    values |>
    Enum.chunk_while(nil, make_chunker_fun(comparer), make_finisher_fun(comparer))
  end

  defp make_chunker_fun(comparer) do
    fn elem, acc -> chunker_by_paternity(elem, acc, comparer) end
  end

  defp chunker_by_paternity(elem, nil, _) do
    {:cont, %Tree.Node{value: elem, children: []}}
  end

  defp chunker_by_paternity(elem, node, comparer) do
    if comparer.(node.value, elem) do
      {:cont, Tree.Node.append_child(node, elem)}
    else
      {:cont, recursively_make(node, comparer), %Tree.Node{value: elem, children: []}}
    end
  end

  defp make_finisher_fun(comparer) do
    (fn node -> {:cont, recursively_make(node, comparer), nil} end)
  end

  defp recursively_make(node = %Tree.Node{}, comparer) do
    %Tree.Node{node | children: make_from_nodes(node.children, comparer)}
  end

end
