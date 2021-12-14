defmodule Day14 do
  def parseInput() do
    lines = File.read!("input/day14.txt") |> String.split("\n")
    [starter, _ | rules] = lines

    rules = for rule <- rules, into: %{}, do: (
      [from, to] = String.split(rule, " -> ")
      {from, to}
    )

    {starter, rules}
  end

  def incrementMapValue(map, key) do
    Map.put(map, key, 1 + Map.get(map, key, 0))
  end

  def doStep({polymer, rules}) do
    pairs = for i <- 0 .. (String.length(polymer) - 2), into: [], do: Map.get(rules, String.slice(polymer, i, 2), "")
    pairs = pairs ++ [""]

    res = Enum.reduce(0 .. (String.length(polymer) -1), "", fn i, acc ->
      acc <> String.slice(polymer, i, 1) <> Enum.at(pairs, i)
    end)
  end

  def countLetters(s) do
    Enum.reduce( 0 .. String.length(s) - 1, %{}, fn i, acc ->
      incrementMapValue(acc, String.slice(s, i, 1))
    end)
  end

  def getVal(map) do
    Enum.max(Map.values(map)) - Enum.min(Map.values(map))
  end

  def solvePartA() do
    {start, rules} = Day14.parseInput

    res = Enum.reduce(0 .. 9, start, fn _, acc ->
      doStep({acc, rules})
    end)

    countLetters(res)
     |> getVal()
  end


  def solvePartB() do
    lines = Day14.getLines
    lines |> hd
  end

end

IO.puts(Day14.solvePartA())
# IO.puts(Day14.solvePartB())
