defmodule Day15 do
  def getLines() do
    File.read!("input/day15.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day15.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day15.getLines
    lines |> hd
  end

end

IO.puts(Day15.solvePartA())
IO.puts(Day15.solvePartB())
