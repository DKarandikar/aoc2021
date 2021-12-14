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

  def incrementMapValue(map, key, val), do: Map.put(map, key, val + Map.get(map, key, 0))
  def getVal(m), do: Enum.max(Map.values(m)) - Enum.min(Map.values(m))

  def runSimulation(steps) do
    {start, rules} = Day14.parseInput
    start = processStarter(start)

    Enum.reduce(0 .. steps - 1, start, fn _, acc ->
      applyStep(acc, rules)
    end)
      |> countLettersMap()
      |> getVal()
  end

  def processStarter(s) do
    Enum.reduce( 0 .. String.length(s) - 2, %{}, fn i, acc ->
      incrementMapValue(acc, String.slice(s, i, 2), 1)
    end)
  end

  def applyStep(pairSet, rules) do
    Enum.reduce(Map.keys(pairSet), %{}, fn key, acc ->
      insert = Map.get(rules, key, nil)
      if insert == nil, do: acc, else: (

        new_1 = String.slice(key, 0, 1) <> insert
        new_2 = insert <> String.slice(key, 1, 1)

        acc = incrementMapValue(acc, new_1, Map.get(pairSet, key, 0))
        incrementMapValue(acc, new_2, Map.get(pairSet, key, 0))
      )
    end)
  end

  def countLettersMap(m) do
    start_letters = Enum.reduce( Map.keys(m), %{}, fn key, acc ->
      incrementMapValue(acc, String.slice(key, 0, 1), Map.get(m, key, 0))
    end)

    end_letters = Enum.reduce( Map.keys(m), %{}, fn key, acc ->
      incrementMapValue(acc, String.slice(key, 1, 1), Map.get(m, key, 0))
    end)

    Map.merge(start_letters, end_letters, fn _, x, y -> max(x, y) end)
  end

  def solvePartA(), do: runSimulation(10)
  def solvePartB(), do: runSimulation(40)

end

IO.puts(Day14.solvePartA())
IO.puts(Day14.solvePartB())
