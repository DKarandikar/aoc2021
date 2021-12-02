defmodule Day3 do
  def getLines() do
    File.read!("input/day3.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day3.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day3.getLines
    lines |> hd
  end

end

IO.puts(Day3.solvePartA())
IO.puts(Day3.solvePartB())
