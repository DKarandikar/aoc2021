defmodule Day8 do
  def getLines() do
    lines = File.read!("input/day8.txt")
    |> String.split("\n")

    Enum.map(lines, fn x -> String.split(x, "|") end)
  end

  def solvePartA() do
    lines = Day8.getLines
    Enum.reduce(lines, 0, fn line, acc ->
      [input, output] = line
      u = String.split(String.trim(output), " ")
        |> Enum.filter(fn x -> String.length(x) == 3 || String.length(x) == 7 || String.length(x) == 2 || String.length(x) == 4 end )
        |> length()
      acc + u
    end)
  end

  def solvePartB() do
    lines = Day8.getLines
    lines |> hd
  end

end

IO.inspect(Day8.solvePartA())
# IO.puts(Day8.solvePartB())
