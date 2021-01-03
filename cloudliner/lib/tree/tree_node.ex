defmodule Tree.Node do
  defstruct value: nil, children: []

  def append_child(node = %Tree.Node{children: []}, element) do
    %Tree.Node{node | children: [element] }
  end

  def append_child(node = %Tree.Node{}, element) do
    %Tree.Node{node | children: Enum.reverse([element | Enum.reverse(node.children)]) }
  end

end
