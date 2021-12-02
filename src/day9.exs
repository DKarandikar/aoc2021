defmodule Day9 do
  def getLines() do
    File.read!("input/day9.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day9.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day9.getLines
    lines |> hd
  end

end

IO.puts(Day9.solvePartA())
IO.puts(Day9.solvePartB())
