defmodule Day6 do
  def getLines() do
    File.read!("input/day6.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day6.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day6.getLines
    lines |> hd
  end

end

IO.puts(Day6.solvePartA())
IO.puts(Day6.solvePartB())
