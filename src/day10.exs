defmodule Day10 do
  def getLines() do
    File.read!("input/day10.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day10.getLines

    lines
      |> Enum.map(&getCorruptChar/1)
      |> Enum.map(&getScore/1)
      |> Enum.sum()

  end

  def getScore(char) do
    cond do
      char == ">" -> 25137
      char == "}" -> 1197
      char == "]" -> 57
      char == ")" -> 3
      true -> 0
    end
  end

  def getCorruptChar(line) do
    opening = MapSet.new(["(", "<", "{", "["])
    closing = MapSet.new([")", ">", "}", "]"])
    pairs = %{"(" => ")", "[" => "]", "<" => ">", "{" => "}"}

    r = Enum.reduce_while(String.graphemes(line), [], fn c, acc ->
      if MapSet.member?(opening, c), do: (
        {:cont, [c | acc]}
      ), else: (
        [mostRecent | t] = acc
        if Map.fetch!(pairs, mostRecent) != c, do: {:halt, c}, else: {:cont, t}
      )
    end)

    cond do
      is_list(r) -> nil
      true -> r
    end

  end

  def solvePartB() do
    lines = Day10.getLines
    lines |> hd
  end

end

IO.puts(Day10.solvePartA())
# IO.puts(Day10.solvePartB())
