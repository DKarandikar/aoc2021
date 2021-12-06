defmodule Day6 do
  def getLines() do
    File.read!("input/day6.txt") |> String.split("\n")
  end

  def incrementMapValue(map, key, val) do
    Map.put(map, key, val + Map.get(map, key, 0))
  end

  def simulateFish(num_days) do
    Day6.getLines
      |> hd
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(%{}, fn i, map -> Day6.incrementMapValue(map, i, 1) end)
      |> runFishSimulation(num_days)
      |> sumFish
  end

  def runFishSimulation(fish, num_days) do
    Enum.reduce(1..num_days, fish, fn _, m -> Day6.doDay(m) end)
  end

  def doDay(m) do
    { new_births, new_map } = Enum.reduce(Map.keys(m), %{}, fn i, map -> Map.put(map, (i-1), Map.get(m, i)) end)
      |> Map.pop(-1, 0)

    new_map
      |> Day6.incrementMapValue(6, new_births)
      |> Day6.incrementMapValue(8, new_births)
  end

  def sumFish(m) do
    Enum.sum(Map.values(m))
  end

  def solvePartA() do
    simulateFish(80)
  end

  def solvePartB() do
    simulateFish(256)
  end

end

IO.puts(Day6.solvePartA())
IO.puts(Day6.solvePartB())
