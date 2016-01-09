defmodule MorseRemoval do
  @moduledoc
  def find_matches(string, matcher), do: do_find_matches([], string, matcher)

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

  def remove(string, removal) do
    find_matches(Morse.encode(string), Morse.encode(removal)) |> remove_matches(Morse.encode(string)) |> Enum.uniq
  end

  defp remove_matches(matches, string), do: do_remove_matches([], matches, string)

  defp do_remove_matches(results, [], string), do: results
  defp do_remove_matches(results, [indices | tail], string) do
    string |> to_char_list |> remove_indices(indices) |> to_string |> add_to(results) |> do_remove_matches(tail, string)
  end

  defp remove_indices(string, indices) do
    Enum.reduce(indices,string, fn(index,string) -> List.delete_at(string,index) end)
  end

  defp add_to(element, collection) when is_list(collection), do: [element | collection]

  def unique_count(string, removal), do: string |> remove(removal) |> Enum.count
end
