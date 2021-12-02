defmodule Day17 do
  def getLines() do
    File.read!("input/day17.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day17.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day17.getLines
    lines |> hd
  end

end

IO.puts(Day17.solvePartA())
IO.puts(Day17.solvePartB())
