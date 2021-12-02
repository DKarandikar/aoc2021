defmodule Day5 do
  def getLines() do
    File.read!("input/day5.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day5.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day5.getLines
    lines |> hd
  end

end

IO.puts(Day5.solvePartA())
IO.puts(Day5.solvePartB())
