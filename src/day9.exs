defmodule Day9 do
  def getLines(), do: File.read!("input/day9.txt") |> String.split("\n")
  def getArray(), do: Day9.getLines |> Enum.map(fn x -> x |> String.graphemes() |> Enum.map(&String.to_integer/1) end)

  def positions(), do: [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]

  def getVal(array, x, y), do: array |> Enum.at(y) |> Enum.at(x)

  def getLowPoints(array) do
    maxX = length(array |> hd)
    maxY = length(array)

    Enum.reduce(0.. maxY - 1, [], fn y, acc ->
      Enum.reduce(0 .. maxX - 1, acc, fn x, acc2 ->
        loc_value = getVal(array, x, y)

        vals_inside = Enum.map(positions(), fn move -> {x + elem(move, 0), y + elem(move, 1)} end)
          |> Enum.filter(fn {x1, y1} -> x1 > -1 && y1 > -1 && x1 < maxX && y1 < maxY end)
          |> Enum.map(fn {x1, y1} -> getVal(array, x1, y1) end)

        if length(vals_inside) == length(Enum.filter(vals_inside, fn val -> val > loc_value end)), do:
          [{x, y} | acc2],
        else:
          acc2
      end)
    end )
  end

  def solvePartA() do
    array = getArray()
    array
      |> getLowPoints()
      |> Enum.map(fn {x, y} -> getVal(array, x, y) end)
      |> Enum.map(fn x -> x + 1 end)
      |> Enum.sum()
  end

  def solvePartB() do
    array = getArray()
    rv = array
      |> getLowPoints()
      |> Enum.map(fn x -> findBasinSize(array, x) end)
      |> Enum.map(&MapSet.size/1)
      |> Enum.sort(&>=/2)

    Enum.at(rv, 0) * Enum.at(rv, 1) * Enum.at(rv, 2)
  end

  def findBasinSize(array, {x, y}) do
    Enum.reduce_while(Stream.cycle([0]), {[{x, y}], MapSet.new()}, fn _, {sofar, done} ->

      if length(sofar) == 0, do: {:halt, done}, else: (
        [{x, y} | sofar] = sofar
        done = MapSet.put(done, {x, y})

        # Find all adjacent locations that aren't filtered out as below
        new_coords = Enum.map(positions(), fn move -> {x + elem(move, 0), y + elem(move, 1)} end)
        # Inside the boundaries
        |> Enum.filter(fn {x1, y1} -> x1 > -1 && y1 > -1 && x1 < (length(array |> hd)) && y1 < (length(array)) end)
        # Not something we've seen before
        |> Enum.filter(fn {x1, y1} -> not MapSet.member?(MapSet.union(MapSet.new(sofar), done), {x1, y1}) end)
        # Not a 'wall' i.e. not height 9
        |> Enum.filter(fn {x1, y1} -> getVal(array, x1, y1) != 9 end)

        {:cont, {Enum.concat(sofar, new_coords), done}}
      )
    end)
  end
end

IO.inspect(Day9.solvePartA())
IO.inspect(Day9.solvePartB())
