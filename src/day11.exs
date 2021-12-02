defmodule Day11 do
  def getLines() do
    File.read!("input/day11.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day11.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day11.getLines
    lines |> hd
  end

end

IO.puts(Day11.solvePartA())
IO.puts(Day11.solvePartB())
