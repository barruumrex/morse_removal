defmodule Removal do
  use Bitwise
  @moduledoc

  def find_removal_combinations(base, removals), do: do_find_removal_combinations([], base, removals)

  defp do_find_removal_combinations(:no_match, _base, _removal), do: []
  defp do_find_removal_combinations(acc, _base, []), do: acc
  defp do_find_removal_combinations(acc, base, [removal | tail]) do
    base |> find_indices(removal) |> insert_indices(acc) |> do_find_removal_combinations(base, tail)
  end

  defp find_indices(base, removal), do: do_find_indices([], 1, base, removal)

  defp do_find_indices(acc, _index, [], _removal), do: acc
  defp do_find_indices(acc, index, [letter | tail], removal) when letter==removal do
    index |> add_to(acc) |> do_find_indices(bsl(index,1), tail, removal)
  end
  defp do_find_indices(acc, index, [_letter | tail], removal) do
    acc |> do_find_indices(bsl(index,1), tail, removal)
  end

  defp insert_indices(candidates, indices), do: do_insert_indices([], Enum.reverse(indices), candidates)

  defp do_insert_indices(_acc, [], candidates), do: candidates
  defp do_insert_indices([], _indices, []), do: :no_match
  defp do_insert_indices(acc, _indices, []), do: acc |> Enum.reverse |> List.flatten
  defp do_insert_indices([], indices, candidates) when hd(indices) > hd(candidates), do: :no_match
  defp do_insert_indices(acc, indices, candidates) when hd(indices) > hd(candidates) do
    acc |> Enum.reverse |> List.flatten
  end
  defp do_insert_indices(acc, indices, [candidate | tail]) do
    indices |> insert_index(candidate) |> add_to(acc) |> do_insert_indices(indices, tail)
  end

  defp insert_index(indices, candidate), do: do_insert_index([], indices, candidate)

  defp do_insert_index(acc, [], _candidate), do: acc
  defp do_insert_index(acc, [index | tail], candidate) when candidate > index do
    index |> bor(candidate) |> add_to(acc) |> do_insert_index(tail, candidate)
  end
  defp do_insert_index(acc, _indices, _candidate), do: acc

  def remove_from(removals, string), do: Enum.map(removals, fn(indices) -> do_remove_from([], indices, string) end)

  defp do_remove_from(acc, _indices, []), do: acc |> Enum.reverse
  defp do_remove_from(acc, indices, [_letter | tail]) when (indices &&& 1) == 1 do
    do_remove_from(acc, bsr(indices,1), tail)
  end
  defp do_remove_from(acc, indices, [letter | tail]) do
    letter |> add_to(acc) |> do_remove_from(bsr(indices,1), tail)
  end

  defp add_to([], collection), do: collection
  defp add_to(element, collection) when is_list(collection), do: [element | collection]
end
