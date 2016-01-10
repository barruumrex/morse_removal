defmodule MorseRemovalTest do
  use ExUnit.Case
  doctest MorseRemoval

  test "get indices against empty string" do
    assert MorseRemoval.find_matches("", "_") == []
  end

  test "get indices where there are no matches" do
    assert MorseRemoval.find_matches("*.*.*.", "_") == []
  end

  test "get indices of all matches" do
    assert MorseRemoval.find_matches("*.*.*.", "*") == [[4], [2], [0]]
  end

  test "add empty lists" do
    assert MorseRemoval.add_indices([], []) == []
  end

  test "add list to an empty list" do
    assert MorseRemoval.add_indices([0, 2, 4], []) == [[4], [2], [0]]
  end

  test "add list to a single result" do
    assert MorseRemoval.add_indices([1 ,2 ,3], [[0]]) == [[1, 0], [2, 0], [3, 0]]
  end

  test "add a single element list where every addition is succesful" do
    assert MorseRemoval.add_indices([5], [[0], [2], [4]]) == [[5, 4], [5, 2], [5, 0]]
  end

  test "combine multi element list to multi element result set" do
    assert MorseRemoval.add_indices([1, 4], [[0], [2], [4]]) == [[1, 0], [4, 2], [4, 0]]
  end

  test "get indices for multi character match" do
    assert MorseRemoval.find_matches("*.*.", "*.") == [[1, 0], [3, 0], [3, 2]]
  end

  test "create morse and output removal combinations" do
    assert MorseRemoval.remove("AB", ["R"]) == [ "_-**", "-_**" ]
  end

  test "output number of unique combinations after removal" do
    assert MorseRemoval.unique_count("AB", "R") == 2
  end

  test "output count when removing 'Help' from 'Hello World'" do
    assert MorseRemoval.unique_count("Hello World", "Help") == 1311
  end

  test "remove multiple and output combinations" do
    assert MorseRemoval.remove("AB", ["R","E"]) == ["-_*", "_-*"]
  end

  test "output count when removing multiples" do
    #assert MorseRemoval.unique_count("AB", ["R","E"]) == 2
  end

  test "output count after removing both 'ST', and 'ZN' from 'ABCD'" do
    assert MorseRemoval.unique_count("ABCD", ["ST", "ZN"]) == 5
  end

end
