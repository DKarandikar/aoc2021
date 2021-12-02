defmodule Day4 do
  def getLines() do
    File.read!("input/day4.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day4.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = Day4.getLines
    lines |> hd
  end

end

IO.puts(Day4.solvePartA())
IO.puts(Day4.solvePartB())
