defmodule CsvReaderTest do
  use ExUnit.Case
  doctest CsvReader

  test "greets the world" do
    assert CsvReader.hello() == :world
  end
end
