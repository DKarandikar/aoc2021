defmodule Day14 do
  def getLines() do
    File.read!("input/day14.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day14.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day14.getLines
    lines |> hd
  end

end

IO.puts(Day14.solvePartA())
IO.puts(Day14.solvePartB())
