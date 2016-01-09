defmodule MorseBench do
  use Benchfella

  bench "hello world encode" do
    Morse.encode("Hello World")
  end

  bench "pangram encode" do
    Morse.encode("Sphinx of black quartz, judge my vow")
  end

  bench "remove 'Help' from 'Hello World'" do
    MorseRemoval.remove("Hello World","Help")
  end

  bench "remove 'Yoda' from 'The Star Wars Saga'" do
    MorseRemoval.remove("The Star Wars Saga","Yoda")
  end
end
