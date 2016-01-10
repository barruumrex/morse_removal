defmodule MorseRemoval do
  @moduledoc
  def unique_count(string, removal) when is_binary(removal), do: unique_count(string, [removal])
  def unique_count(string, removal) when is_list(removal) do
    do_unique_count([Morse.encode(string)],Enum.map(removal, &Morse.encode/1))
  end

  defp do_unique_count(strings, []), do: strings |> Enum.count
  defp do_unique_count(strings, [removal|tail]), do: strings |> multi_string_remove(removal) |> do_unique_count(tail)

  defp multi_string_remove(strings, removal), do: do_multi_string_remove([], strings, removal)

  defp do_multi_string_remove(results, [], _removal), do: results |> Enum.uniq
  defp do_multi_string_remove(results, [string | tail], removal) do
    string
    |> Removal.find_removal_combinations(removal)
    |> Removal.remove_from(string)
    |> Enum.concat(results)
    |> do_multi_string_remove(tail,removal)
  end
end
