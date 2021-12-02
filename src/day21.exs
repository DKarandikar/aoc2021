defmodule Day21 do
  def getLines() do
    File.read!("input/day21.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day21.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day21.getLines
    lines |> hd
  end

end

IO.puts(Day21.solvePartA())
IO.puts(Day21.solvePartB())
