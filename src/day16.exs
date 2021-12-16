defmodule Day16 do
  def getLines() do
    File.read!("input/day16.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day16.getLines
    lines |> hd |> Base.decode16!() |> packet()
  end

  def packet(<<version::size(3), type::size(3), rem::bitstring>>) when type == 4 do
     literal(rem, 0, version)
  end

  def literal(<<0::1, value::size(4), rem::bitstring>>, acc, v), do: {rem, acc * 16 + value, v}
  def literal(<<1::1, value::size(4), rem::bitstring>>, acc, v), do: literal(rem, acc * 16 + value, v)

  def solvePartB() do
    lines = Day16.getLines
    lines |> hd
  end

end

IO.inspect(Day16.solvePartA())
IO.inspect(Day16.solvePartB())
