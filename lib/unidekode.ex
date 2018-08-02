defmodule Unidekode do
  @moduledoc """
  Documentation for Unidekode.
  """

  @doc """
  Transliterate Unicode characters to US-ASCII.

  ## Examples

      iex> Unidekode.to_ascii("código")
      "codigo"

      iex> Unidekode.to_ascii("código😀")
      "codigo"

      iex> Unidekode.to_ascii('código')
      'codigo'

      iex> Unidekode.to_ascii('código℗')
      'codigo'
  """
  @spec to_ascii(binary() | charlist()) :: binary() | charlist()
  def to_ascii(string), do: to_ascii(string, <<>>)

  defp to_ascii(<<>>, ascii), do: ascii
  defp to_ascii([], ascii),   do: to_charlist(ascii)
  defp to_ascii(<<b::utf8, rest::binary()>>, ascii) do
    to_ascii(rest, <<ascii::binary(), transliterate(b)::binary()>>)
  end
  defp to_ascii([b | rest], ascii) do
    to_ascii(rest, <<ascii::binary(), transliterate(b)::binary()>>)
  end

  @matches :unidekode
           |> :code.priv_dir()
           |> Path.join("UnicodeData.txt")
           |> File.stream!([:read], :line)
           |> Stream.filter(&String.contains?(&1, "WITH"))
           |> Stream.map(&:string.split(&1, ";", :all))
           |> Stream.flat_map(fn
            [capital_match, <<"LATIN CAPITAL LETTER ", letter::binary-size(1), _::binary()>>, _, _, _, _, _, _, _, _, _, _, _, small_match, _] ->
              [{String.to_integer(capital_match, 16), letter}, {String.to_integer(small_match, 16), String.downcase(letter)}]
            _ -> []
            end)
           |> Enum.into(for x <- '!"#%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~\s\t\n', do: {x, <<x>>})
           |> Enum.uniq()

  @doc !"""
  List all the matches generated from the `UnicodeData.txt`.

  ## Examples

      iex> Unidekode.matches()
      [{33, "!"}, ...]
  """
  @spec matches() :: [{integer(), binary()}, ...]
  def matches(), do: @matches

  for {match, result} <- @matches do
    defp transliterate(unquote(match)), do: unquote(result)
  end
  defp transliterate(_), do: <<>>
end
