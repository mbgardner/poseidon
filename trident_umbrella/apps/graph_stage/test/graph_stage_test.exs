defmodule GraphStageTest do
  use ExUnit.Case
  doctest GraphStage

  test "greets the world" do
    assert GraphStage.hello() == :world
  end
end
