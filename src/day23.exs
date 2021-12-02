defmodule Day23 do
  def getLines() do
    File.read!("input/day23.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day23.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day23.getLines
    lines |> hd
  end

end

IO.puts(Day23.solvePartA())
IO.puts(Day23.solvePartB())
