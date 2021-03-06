defmodule Day24 do
  def getLines() do
    File.read!("input/day24.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day24.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day24.getLines
    lines |> hd
  end

end

IO.puts(Day24.solvePartA())
IO.puts(Day24.solvePartB())
