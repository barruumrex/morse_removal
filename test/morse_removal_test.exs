defmodule MorseRemovalTest do
  use ExUnit.Case
  doctest MorseRemoval

  test "output number of unique combinations after removal" do
    assert MorseRemoval.unique_count("AB", "R") == 2
  end

  test "output count when removing 'Help' from 'Hello World'" do
    assert MorseRemoval.unique_count("Hello World", "Help") == 1311
  end

  test "output count when removing multiples" do
    assert MorseRemoval.unique_count("AB", ["R","E"]) == 2
  end

  test "output count after removing both 'ST', and 'ZN' from 'ABCD'" do
    assert MorseRemoval.unique_count("ABCD", ["ST", "ZN"]) == 5
  end
end
