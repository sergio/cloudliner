defmodule CloudlinerTest do
  use ExUnit.Case
  doctest Cloudliner

  test "greets the world" do
    assert Cloudliner.hello() == :world
  end
end
