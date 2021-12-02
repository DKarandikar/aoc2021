defmodule Day22 do
  def getLines() do
    File.read!("input/day22.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day22.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day22.getLines
    lines |> hd
  end

end

IO.puts(Day22.solvePartA())
IO.puts(Day22.solvePartB())
