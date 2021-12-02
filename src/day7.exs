defmodule Day7 do
  def getLines() do
    File.read!("input/day7.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day7.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day7.getLines
    lines |> hd
  end

end

IO.puts(Day7.solvePartA())
IO.puts(Day7.solvePartB())
