defmodule Day15 do
  def getLines() do
    File.read!("input/day15.txt")
      |> String.split("\n")
      |> Enum.map(fn x -> String.graphemes(x) end)
      |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
  end

  def getLoc(data, x, y), do: data |> Enum.at(y) |> Enum.at(x)

  def getMap(costs, x, y), do: Map.get(costs, {x, y}, 1000)

  def iterativeSolve() do
    big = 10000
    data = getLines()

    res = Enum.reduce(0..20, %{{0, 0} => 0}, fn _, acc ->
      Enum.reduce(0 .. length(data) - 1, acc, fn y, acc2 ->
        Enum.reduce(0 .. length(Enum.at(data, y)) - 1, acc2, fn x, costs ->
          if (x == 0 && y == 0), do: costs, else: (
            cost = getLoc(data, x, y)
            min_step = Enum.min([
              (if x > 0, do: getMap(costs, x - 1, y), else: big),
              (if y > 0, do: getMap(costs, x, y - 1), else: big),
              (if x < length(Enum.at(data, y)) - 1, do: getMap(costs, x + 1, y), else: big),
              (if y < length(data) - 1, do: getMap(costs, x, y + 1), else: big),
            ])
            Map.put(costs, {x, y}, cost + min_step)
          )
        end)
      end)
    end)
    Map.get(res, {length(Enum.at(data, 0)) - 1, length(data) - 1})
  end

  def solvePartA() do
    iterativeSolve()
  end

  def solvePartB() do
    lines = Day15.getLines
    lines |> hd
  end

end

IO.inspect(Day15.solvePartA())
# IO.puts(Day15.solvePartB())
