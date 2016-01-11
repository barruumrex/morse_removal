defmodule RemovalTest do
  use ExUnit.Case
  use Bitwise
  doctest Removal

  test "get indices against empty string" do
    assert Removal.find_removal_combinations('', '_') == []
  end

  test "get indices where there are no matches" do
    assert Removal.find_removal_combinations('*.*.*.', '_') == []
  end

  test "get indices matches for single character" do
    assert Removal.find_removal_combinations('*.*.*.', '*') == [bsl(1,4), bsl(1,2), 1]
  end

  test "get indices matches for two characters" do
    assert Removal.find_removal_combinations('*.*', '*.') == [1 ||| bsl(1,1)]
  end

  test "get indices when second doesn't match" do
    assert Removal.find_removal_combinations('*.*.*.*.','*-') == []
  end

  test "get indices when second doesn't match but third does" do
    assert Removal.find_removal_combinations('*.*.*.*.','*-*') == []
  end

  test "get indices when some matches die out" do
    combination = [1 ||| bsl(1,1) ||| bsl(1,2) ||| bsl(1,4) ||| bsl(1,6) ||| bsl(1,7)]
    assert Removal.find_removal_combinations('*.*.*.*.','*.***.') == combination
  end

  test "remove combinations from empty string" do
    assert Removal.remove_from([1], '') == ['']
  end

  test "remove single combination from string" do
    assert Removal.remove_from([6], '1234') == ['14']
  end

  test "remove all combinations from string" do
    assert Removal.remove_from([6,9], '1234') == ['14','23']
  end
end
