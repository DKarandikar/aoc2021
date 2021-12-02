defmodule Day16 do
  def getLines() do
    File.read!("input/day16.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day16.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day16.getLines
    lines |> hd
  end

end

IO.puts(Day16.solvePartA())
IO.puts(Day16.solvePartB())
