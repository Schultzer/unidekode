defmodule UnidekodeTest do
  use ExUnit.Case
  doctest Unidekode

  test "to_ascii/1" do
    assert Unidekode.to_ascii("código") == "codigo"
    assert Unidekode.to_ascii('código') == 'codigo'
    assert Unidekode.to_ascii('código!"#%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~\s\t\n') == 'codigo!"#%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~\s\t\n'
  end
end
