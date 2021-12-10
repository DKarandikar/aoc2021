defmodule Day10 do
  def getLines() do
    File.read!("input/day10.txt") |> String.split("\n")
  end

  def solvePartA() do
    getLines()
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
    r = parseLine(line)
    if is_list(r), do: nil, else: r
  end

  def parseLine(line) do
    opening = MapSet.new(["(", "<", "{", "["])
    pairs = %{"(" => ")", "[" => "]", "<" => ">", "{" => "}"}

    Enum.reduce_while(String.graphemes(line), [], fn c, acc ->
      if MapSet.member?(opening, c), do: (
        {:cont, [c | acc]}
      ), else: (
        [mostRecent | t] = acc
        if Map.fetch!(pairs, mostRecent) != c, do: {:halt, c}, else: {:cont, t}
      )
    end)
  end

  def solvePartB() do
    lines = Day10.getLines
    li = lines
      |> Enum.map(&parseLine/1)
      |> Enum.filter(&is_list/1)
      |> Enum.map(&getAutocompleteScore/1)
      |> Enum.sort()

    midPos = (length(li) - 1) |> div(2)
    Enum.at(li, midPos)
  end

  def getAutocompleteScore(chars) do
    Enum.reduce(chars, 0, fn c, acc ->
      (acc * 5) + getAutoCharScore(c)
    end)
  end

  def getAutoCharScore(char) do
    cond do
      char == "<" -> 4
      char == "{" -> 3
      char == "[" -> 2
      char == "(" -> 1
      true -> 0
    end
  end

end

IO.puts(Day10.solvePartA())
IO.puts(Day10.solvePartB())
