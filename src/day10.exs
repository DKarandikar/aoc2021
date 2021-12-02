defmodule Day10 do
  def getLines() do
    File.read!("input/day10.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day10.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day10.getLines
    lines |> hd
  end

end

IO.puts(Day10.solvePartA())
IO.puts(Day10.solvePartB())
