defmodule Day18 do
  def getLines() do
    File.read!("input/day18.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day18.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day18.getLines
    lines |> hd
  end

end

IO.puts(Day18.solvePartA())
IO.puts(Day18.solvePartB())
