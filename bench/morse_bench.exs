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
    MorseRemoval.unique_count("The Star Wars Saga", "Yoda") |> IO.puts
  end

  bench "remove 'Leia' from 'The Star Wars Saga'" do
    MorseRemoval.unique_count("The Star Wars Saga", "Leia") |> IO.puts
  end

  bench "remove 'Yoda' then 'Leia' from 'The Star Wars Sage'" do
    MorseRemoval.unique_count("The Star Wars Saga", ["Yoda","Leia"]) |> IO.puts
  end
end
