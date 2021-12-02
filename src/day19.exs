defmodule Day19 do
  def getLines() do
    File.read!("input/day19.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day19.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day19.getLines
    lines |> hd
  end

end

IO.puts(Day19.solvePartA())
IO.puts(Day19.solvePartB())
