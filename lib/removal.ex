defmodule Removal do
  use Bitwise
  @moduledoc

  def find_removal_combinations(base, removals), do: do_find_removal_combinations([], base, removals)

  defp do_find_removal_combinations(acc, _base, <<>>), do: acc
  defp do_find_removal_combinations(acc, base, <<removal::binary-size(1), tail::binary>>) do
    base |> find_indices(removal) |> insert_indices(acc) |> do_find_removal_combinations(base, tail)
  end

  defp find_indices(base, removal), do: do_find_indices([], 1, base, removal)

  defp do_find_indices(acc, _index, <<>>, _removal), do: acc
  defp do_find_indices(acc, index, <<letter::binary-size(1), tail::binary>>, removal) when letter==removal do
    index |> add_to(acc) |> do_find_indices(bsl(index,1), tail, removal)
  end
  defp do_find_indices(acc, index, <<_letter::binary-size(1), tail::binary>>, removal) do
    acc |> do_find_indices(bsl(index,1), tail, removal)
  end

  defp insert_indices(candidates, indices), do: do_insert_indices([], indices, candidates)

  defp do_insert_indices(_acc, [], candidates), do: candidates
  defp do_insert_indices(acc, _indices, []), do: acc
  defp do_insert_indices(acc, indices, [candidate | tail]) do
    indices |> insert_index(candidate, acc) |> do_insert_indices(indices, tail)
  end

  defp insert_index(indices, candidate, acc), do: do_insert_index(acc, indices, candidate)

  defp do_insert_index(acc, [], _candidate), do: acc
  defp do_insert_index(acc, [index | tail], candidate) when candidate > index do
    index |> bor(candidate) |> add_to(acc) |> do_insert_index(tail, candidate)
  end
  defp do_insert_index(acc, [_index | tail], candidate), do: do_insert_index(acc, tail, candidate)

  def remove_from(removals, string), do: Enum.map(removals, fn(indices) -> do_remove_from([], indices, string) end)

  defp do_remove_from(acc, _indices, <<>>), do: acc |> Enum.reverse |> Enum.join
  defp do_remove_from(acc, indices, <<_letter::binary-size(1),tail::binary>>) when (indices &&& 1) == 1 do
    do_remove_from(acc, bsr(indices,1), tail)
  end
  defp do_remove_from(acc, indices, <<letter::binary-size(1),tail::binary>>) do
    letter |> add_to(acc) |> do_remove_from(bsr(indices,1), tail)
  end

  defp add_to(element, collection) when is_list(collection), do: [element | collection]
end
