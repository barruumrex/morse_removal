defmodule MorseRemoval do
  @moduledoc
  def find_matches( string, matcher ), do: do_find_matches( string, matcher, 0, [])

  defp do_find_matches( <<>>, matcher, depth, results ), do: Enum.reverse(results)
  defp do_find_matches( << head::binary-size(1), tail::binary >>, matcher, depth, results ) when head == matcher do
    do_find_matches( tail, matcher, depth + 1, [ depth | results ] )
  end
  defp do_find_matches( << head::binary-size(1), tail::binary >>, matcher, depth, results ) when head != matcher do
    do_find_matches( tail, matcher, depth + 1, results )
  end
end
