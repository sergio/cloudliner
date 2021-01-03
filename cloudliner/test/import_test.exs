defmodule ImportTest do
  use ExUnit.Case

  test "transform yaml file to opml xml" do

    File.read!("./assets/cfn-example.yml") |> convert_to_opml()

  end

end
