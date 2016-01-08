defmodule MorseTest do
  use ExUnit.Case
  doctest Morse

  test "encode single" do
    assert Morse.encode("a") == "*-"
    assert Morse.encode("A") == "*-"
  end

  test "encode examples" do
    assert Morse.encode("AB") == "*-_-***"
    assert Morse.encode("R") == "*-*"
    assert Morse.encode("Hello World") == "****_*_*-**_*-**_---___*--_---_*-*_*-**_-**"
    assert Morse.encode("Help") == "****_*_*-**_*--*"
    assert Morse.encode("ABCD") == "*-_-***_-*-*_-**"
    assert Morse.encode("ST") == "***_-"
    assert Morse.encode("ZN") == "--**_-*"
    assert Morse.encode("The Star Wars Saga") == "-_****_*___***_-_*-_*-*___*--_*-_*-*_***___***_*-_--*_*-"
    assert Morse.encode("Yoda") == "-*--_---_-**_*-"
    assert Morse.encode("Leia") == "*-**_*_**_*-"
  end

  test "encode pangram" do
    morse_sentence = [ "***_*--*_****_**_-*_-**-",
                     "---_**-*",
                     "-***_*-**_*-_-*-*_-*-",
                     "--*-_**-_*-_*-*_-_--**_--**--",
                     "*---_**-_-**_--*_*",
                     "--_-*--",
                     "***-_---_*--" ] |> Enum.join("___")
    assert Morse.encode("Sphinx of black quartz, judge my vow") == morse_sentence
  end
end
