defmodule Day12 do
  def getLines() do
    File.read!("input/day12.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day12.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day12.getLines
    lines |> hd
  end

end

IO.puts(Day12.solvePartA())
IO.puts(Day12.solvePartB())
