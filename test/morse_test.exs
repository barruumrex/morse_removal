defmodule MorseTest do
  use ExUnit.Case
  doctest Morse

  test "encode" do
    assert Morse.encode("a") == "*-"
    assert Morse.encode("A") == "*-"
    assert Morse.encode("ab") == "*-_-***"
    assert Morse.encode("Sphinx of black quartz, judge my vow") == "***_*--*_****_**_-*_-**-___---_**-*___-***_*-**_*-_-*-*_-*-___--*-_**-_*-_*-*_-_--**_--**--___*---_**-_-**_--*_*___--_-*--___***-_---_*--"
  end
end
