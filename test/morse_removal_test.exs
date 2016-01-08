defmodule MorseRemovalTest do
  use ExUnit.Case
  doctest MorseRemoval

  test "get indices of occurences" do
    assert MorseRemoval.find_matches( "*.*.*.", "_") == []
    assert MorseRemoval.find_matches( "", "_") == []
    assert MorseRemoval.find_matches( "*.*.*.", "*") == [ [0],[2],[4] ]
  end

  test "combine indices lists" do
    assert MorseRemoval.add_indices( [], [] ) == []
    assert MorseRemoval.add_indices( [0,2,4], [] ) == [ [0], [2], [4] ]
    assert MorseRemoval.add_indices( [1,2,3], [ [0] ] ) == [ [0,1], [0,2], [0,3] ]
    assert MorseRemoval.add_indices( [5], [ [0], [2], [4] ] ) == [ [0,5], [2,5], [4,5] ]
    assert MorseRemoval.add_indices( [1,4], [ [0], [2], [4] ] ) == [ [0,1], [0,4], [2,4] ]
  end

  test "get indices for multi character match" do
    assert MorseRemoval.find_matches( "*.*.", "*." ) == [ [0,1], [0,3], [2,3] ]
  end

  test "create morse and output removal combincations" do
    assert MorseRemoval.remove("AB","R") == [[0, 1, 4], [0, 3, 4], [0, 1, 5], [0, 3, 5], [0, 1, 6], [0, 3, 6]]
  end

end
