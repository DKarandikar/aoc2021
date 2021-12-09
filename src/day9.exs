defmodule Day9 do
  def getLines() do
    File.read!("input/day9.txt") |> String.split("\n")
  end

  def positions() do
    [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
  end

  def getLowPoints(array) do
    maxX = length(array |> hd)
    maxY = length(array)

    Enum.reduce(0.. maxY - 1, [], fn y, acc ->
      Enum.reduce(0 .. maxX - 1, acc, fn x, acc2 ->
        loc_value = array |> Enum.at(y) |> Enum.at(x)

        coords_inside = Enum.map(positions(), fn move -> {x + elem(move, 0), y + elem(move, 1)} end)
          |> Enum.filter(fn {x1, y1} -> x1 > -1 && y1 > -1 && x1 < maxX && y1 < maxY end)
          |> Enum.map(fn {x1, y1} -> Enum.at(array, y1) |> Enum.at(x1) end)

        if length(coords_inside) == length(Enum.filter(coords_inside, fn val -> val > loc_value end)), do:
          [{x, y} | acc2],
        else:
          acc2
      end)
    end )
  end

  def solvePartA() do
    lines = Day9.getLines
    array = lines |> Enum.map(fn x -> x |> String.graphemes() |> Enum.map(&String.to_integer/1) end)

    array
      |> getLowPoints()
      |> Enum.map(fn {x, y} -> array |> Enum.at(y) |> Enum.at(x) end)
      |> Enum.map(fn x -> x + 1 end)
      |> Enum.sum()
  end

  def solvePartB() do
    lines = Day9.getLines
    array = lines |> Enum.map(fn x -> x |> String.graphemes() |> Enum.map(&String.to_integer/1) end)

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

        pos = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
        new_coords = Enum.map(pos, fn move -> {x + elem(move, 0), y + elem(move, 1)} end)
        |> Enum.filter(fn {x1, y1} -> x1 > -1 && y1 > -1 && x1 < (length(array |> hd)) && y1 < (length(array)) end)
        |> Enum.filter(fn {x1, y1} -> not MapSet.member?(MapSet.union(MapSet.new(sofar), done), {x1, y1}) end)
        |> Enum.filter(fn {x1, y1} -> array |> Enum.at(y1) |> Enum.at(x1) != 9 end)

        {:cont, {Enum.concat(sofar, new_coords), done}}

      )
    end)
  end
end

IO.inspect(Day9.solvePartA())
IO.inspect(Day9.solvePartB())
