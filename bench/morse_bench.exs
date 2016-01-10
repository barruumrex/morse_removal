defmodule MorseBench do
  use Benchfella

  bench "hello world encode" do
    Morse.encode("Hello World")
  end

  bench "pangram encode" do
    Morse.encode("Sphinx of black quartz, judge my vow")
  end

  bench "remove 'Help' from 'Hello World'" do
    MorseRemoval.unique_count("Hello World", "Help")
  end

  bench "remove 'Yoda' from 'The Star Wars Saga'" do
    MorseRemoval.unique_count("The Star Wars Saga", "Yoda")
  end

  bench "remove 'Leia' from 'The Star Wars Saga'" do
    MorseRemoval.unique_count("The Star Wars Saga", "Leia")
  end

  bench "bytecode benchmarck remove 'Leia' from 'The Star Wars'" do
    star_wars = Morse.encode("The Star Wars Saga")
    leia = Morse.encode("Leia")
    star_wars |> Removal.find_removal_combinations(leia) |> Removal.remove_from(star_wars) |> Enum.uniq |> Enum.count
  end

  bench "remove 'Yoda' then 'Leia' from 'The Star Wars Saga'" do
    "The Star Wars Saga" |> MorseRemoval.unique_count(["Yoda","Leia"]) |> IO.puts
  end
end
