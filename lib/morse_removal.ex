defmodule MorseRemoval do
  @moduledoc
  def find_matches( string, matcher ), do: do_find_matches( string, matcher, 0, [])

  defp do_find_matches( <<>>, _matcher, _depth, results ), do: Enum.reverse(results)
  defp do_find_matches( << head::binary-size(1), tail::binary >>, matcher, depth, results ) when head == matcher do
    do_find_matches( tail, matcher, depth + 1, [ depth | results ] )
  end
  defp do_find_matches( << head::binary-size(1), tail::binary >>, matcher, depth, results ) when head != matcher do
    do_find_matches( tail, matcher, depth + 1, results )
  end

  def add_indices( new_list, [] ), do: Enum.map( new_list, fn(n) -> [n] end )
  def add_indices( new_list, combined_list ), do: do_add_indices( new_list, combined_list, [] )

  defp do_add_indices( [], _combined_list, acc), do: acc
  defp do_add_indices( [head | tail], combined_list, acc ) do
    do_add_indices(tail, combined_list, acc ++ add_index(head, combined_list))
  end

  defp add_index( element, combined_list ) do
    do_add_index( element, combined_list, [] )
  end

  defp do_add_index( _element, [], results ), do: results
  defp do_add_index( element, [head | tail], results ) do
    if element > List.last(head) do
      do_add_index( element, tail, results ++ [ head ++ [ element ] ] )
    else
      do_add_index( element, tail, results )
    end
  end
end
