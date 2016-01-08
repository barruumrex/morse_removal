defmodule MorseBench do
  use Benchfella

  bench "hello world encode" do
    Morse.encode("Hello World")
  end
  
  bench "pangram encode" do 
    Morse.encode("Sphinx of black quartz, judge my vow")
  end
end
