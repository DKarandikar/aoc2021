defmodule DayX do
  def getLines() do
    File.read!("input/dayX.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = DayX.getLines
    lines |> hd
  end

  def solvePartB() do
    lines = DayX.getLines
    lines |> hd
  end

end

IO.puts(DayX.solvePartA())
IO.puts(DayX.solvePartB())
