defmodule Day25 do
  def getLines() do
    File.read!("input/day25.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day25.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day25.getLines
    lines |> hd
  end

end

IO.puts(Day25.solvePartA())
IO.puts(Day25.solvePartB())
