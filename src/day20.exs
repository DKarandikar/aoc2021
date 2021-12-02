defmodule Day20 do
  def getLines() do
    File.read!("input/day20.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day20.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day20.getLines
    lines |> hd
  end

end

IO.puts(Day20.solvePartA())
IO.puts(Day20.solvePartB())
