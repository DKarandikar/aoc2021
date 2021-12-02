defmodule Day8 do
  def getLines() do
    File.read!("input/day8.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day8.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day8.getLines
    lines |> hd
  end

end

IO.puts(Day8.solvePartA())
IO.puts(Day8.solvePartB())
