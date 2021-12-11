defmodule Day11 do
  def getLines(), do: File.read!("input/day11.txt") |> String.split("\n")
  def getArray(), do: getLines() |> Enum.map(fn x -> x |> String.graphemes() |> Enum.map(&String.to_integer/1) end)

  def incrementMapValue(map, key, val), do: Map.put(map, key, val + Map.get(map, key, 0))

  def positions(), do: [{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

  def getMap() do
    array = getArray()

    maxX = length(array |> hd)
    maxY = length(array)

    Enum.reduce(0.. (maxY - 1), %{}, fn y, acc ->
      Enum.reduce(0.. (maxX - 1), acc, fn x, acc2 ->
        Map.put(acc2, {x, y}, array |> Enum.at(y) |> Enum.at(x))
      end)
    end)

  end

  def getArraySize() do
    array = getArray()
    length(array) * length(array |> hd)
  end

  def doStep(map) do
    array = getArray()

    maxX = length(array |> hd)
    maxY = length(array)

    toDo = for x <- (0 .. (maxX - 1)), y <-(0 .. (maxY - 1)), do: {x, y}

    # Increment all spaces by 1 to start with
    map = Enum.reduce(toDo, map, fn coord, m ->
      incrementMapValue(m, coord, 1)
    end)

    {map, fired} = Enum.reduce_while(Stream.cycle([0]), {toDo, map, 0, MapSet.new()}, fn _, {todo, map, count, fired} ->

      if length(todo) == 0, do: {:halt, {map, fired}}, else: (
        [next | todo ] = todo
        if Map.get(map, next) > 9 && not MapSet.member?(fired, next), do: (
          {x, y} = next
          fired = MapSet.put(fired, next)
          count = count + 1

          # Get all adjacent positions, in the map, that haven't already fired
          toChange = Enum.map(positions(), fn move -> {x + elem(move, 0), y + elem(move, 1)} end)
            |> Enum.filter(fn {x1, y1} -> x1 > -1 && y1 > -1 && x1 < maxX && y1 < maxY end)
            |> Enum.filter(fn coord -> not MapSet.member?(fired, coord) end)

          # Increment those, and add them to todo to look at again
          map = Enum.reduce(toChange, map, fn coord, m -> incrementMapValue(m, coord, 1) end)
          todo = todo ++ toChange

          {:cont, {todo, map, count, fired}}
        ), else: (
          {:cont, {todo, map, count, fired}}
        )

      )
    end)

    # Set everything that has fired back to 0
    map = Enum.reduce(fired, map, fn coord, m -> Map.put(m, coord, 0) end)

    {map, MapSet.size(fired)}
  end

  def solvePartA() do
    Enum.reduce(0..99, {getMap(), 0}, fn _, {map, count} ->
      {m, c} = doStep(map)
      {m, count + c}
    end)
      |> elem(1)
  end

  def solvePartB() do
    Enum.reduce_while(Stream.cycle([0]), {getMap(), 0}, fn _, {map, step} ->
      {m, c} = doStep(map)

      if c == getArraySize(), do: {:halt, step}, else: {:cont, {m, step + 1}}
    end) + 1
  end
end

IO.inspect(Day11.solvePartA())
IO.puts(Day11.solvePartB())
