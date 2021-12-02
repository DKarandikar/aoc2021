defmodule Day13 do
  def getLines() do
    File.read!("input/day13.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day13.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day13.getLines
    lines |> hd
  end

end

IO.puts(Day13.solvePartA())
IO.puts(Day13.solvePartB())
