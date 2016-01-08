defmodule MorseRemovalTest do
  use ExUnit.Case
  doctest MorseRemoval

  test "get indices of occurences" do
    assert MorseRemoval.find_matches( "*.*.*.", "_") == []
    assert MorseRemoval.find_matches( "", "_") == []
    assert MorseRemoval.find_matches( "*.*.*.", "*") == [0,2,4]
  end

end
