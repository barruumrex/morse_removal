defmodule MorseRemoval do
  @moduledoc
  def unique_count(string, removal) when is_binary(removal), do: string |> remove(removal) |> Enum.count
  def unique_count(string, removal) when is_list(removal) do
    do_unique_count([Morse.encode(string)],Enum.map(removal, &Morse.encode/1))
  end

  defp do_unique_count(strings, []), do: strings |> Enum.count
  defp do_unique_count(strings, [removal|tail]), do: strings |> multi_string_remove(removal) |> do_unique_count(tail)

  defp multi_string_remove(strings, removal), do: do_multi_string_remove([], strings, removal)

  defp do_multi_string_remove(results, [], _removal), do: results |> Enum.uniq
  defp do_multi_string_remove(results, [string | tail], removal) do
    string
    |> find_matches(removal)
    |> remove_matches(string)
    |> Enum.concat(results)
    |> do_multi_string_remove(tail,removal)
  end

  def remove(string, removal) when is_binary(removal), do: remove(string, [removal])
  def remove(string, removal) when is_list(removal) do
    do_remove([], Morse.encode(string), Enum.map(removal, &Morse.encode/1))
  end

  defp do_remove(results, string, []), do: results |> remove_matches(string) |> Enum.uniq
  defp do_remove(results, string, [removal | tail]) do
    string |> find_matches(removal) |> combine_matches(results) |> do_remove(string, tail)
  end

  def find_matches(string, matcher), do: do_find_matches([], string, matcher)

  defp do_find_matches(nil, _string, _matcher), do: []
  defp do_find_matches(results, _string, <<>>), do: results
  defp do_find_matches(results, string, <<remove_char::binary-size(1), tail::binary>>) do
    string |> get_indices(remove_char ) |> add_indices(results) |> do_find_matches(string, tail)
  end

  defp get_indices(string, remove_char), do: do_get_indices(string, remove_char, 0, [])

  defp do_get_indices(<<>>, _matcher, _depth, results), do: Enum.reverse(results)
  defp do_get_indices(<<head::binary-size(1), tail::binary>>, matcher, depth, results) when head == matcher do
    do_get_indices(tail, matcher, depth + 1, [depth | results])
  end
  defp do_get_indices(<<head::binary-size(1), tail::binary>>, matcher, depth, results) when head != matcher do
    do_get_indices(tail, matcher, depth + 1, results)
  end

  def add_indices(new_list, []), do: Enum.reduce(new_list, [], fn(n,acc) -> [[n] | acc] end)
  def add_indices(new_list, combined_list), do: do_add_indices(new_list, combined_list, [])

  defp do_add_indices([], _combined_list, []), do: nil
  defp do_add_indices([], _combined_list, acc), do: acc
  defp do_add_indices([head | tail], combined_list, acc) do
    do_add_indices(tail, combined_list, acc ++ add_index(head, combined_list))
  end

  defp add_index(element, combined_list) do
    do_add_index(element, combined_list, [])
  end

  defp do_add_index(_element, [], results), do: results
  defp do_add_index(element, [head | tail], results) when element > hd(head) do
    do_add_index(element, tail, [[element | head] | results])
  end
  defp do_add_index(element, [_head | tail], results) do
    do_add_index(element, tail, results)
  end

  defp combine_matches(new_matches, []), do: new_matches
  defp combine_matches(new_matches, old_matches), do: do_combine_matches([], new_matches, old_matches)

  defp do_combine_matches(results, [], _old_matches), do: results
  defp do_combine_matches(results, [ indices | tail ], old_matches) do
    old_matches |> insert_indices(indices) |> Enum.concat(results) |> do_combine_matches(tail, old_matches)
  end

  defp insert_indices(matches, indices), do: do_insert_indices([], matches, indices)

  defp do_insert_indices(results, [], _new_indices), do: results
  defp do_insert_indices(results, [ start_indices | tail ], new_indices) do
    start_indices |> combine_indices(new_indices) |> add_if_not_empty(results) |> do_insert_indices(tail, new_indices)
  end

  defp combine_indices(start_indices, new_indices), do: do_combine_indices([], start_indices, new_indices)

  defp do_combine_indices(results, [], []), do: results |> Enum.reverse
  defp do_combine_indices(results, [head | tail], []), do: head |> add_to(results) |> do_combine_indices(tail,[])
  defp do_combine_indices(results, [], [head | tail]), do: head |> add_to(results) |> do_combine_indices([], tail)
  defp do_combine_indices(_results, left, right) when hd(left) == hd(right), do: []
  defp do_combine_indices(results, [left_head | tail], right) when left_head > hd(right) do
    left_head |> add_to(results) |> do_combine_indices(tail, right)
  end
  defp do_combine_indices(results, left, [right_head | tail]) when right_head > hd(left) do
    right_head |> add_to(results) |> do_combine_indices(left, tail)
  end

  defp remove_matches(matches, string), do: do_remove_matches([], matches, string)

  defp do_remove_matches(results, [], _string), do: results
  defp do_remove_matches(results, [indices | tail], string) do
    string |> to_char_list |> remove_indices(indices) |> to_string |> add_to(results) |> do_remove_matches(tail, string)
  end

  defp remove_indices(string, indices) do
    Enum.reduce(indices,string, fn(index,string) -> List.delete_at(string,index) end)
  end

  defp add_to(element, collection) when is_list(collection), do: [element | collection]
  defp add_if_not_empty(element, collection) when length(element) == 0, do: collection
  defp add_if_not_empty(element, collection), do: add_to(element, collection)


end
