defmodule Day9 do
  def getLines() do
    File.read!("input/day9.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day9.getLines
    array = lines |> Enum.map(fn x -> x |> String.graphemes() |> Enum.map(&String.to_integer/1) end)

    maxX = length(array |> hd)
    maxY = length(array)

    pos = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]

    Enum.reduce(0.. maxY - 1, [], fn y, acc ->
      Enum.reduce(0 .. maxX - 1, acc, fn x, acc2 ->
        loc_value = array |> Enum.at(y) |> Enum.at(x)

        coords_inside = Enum.map(pos, fn move -> {x + elem(move, 0), y + elem(move, 1)} end)
          |> Enum.filter(fn {x1, y1} -> x1 > -1 && y1 > -1 && x1 < maxX && y1 < maxY end)
          |> Enum.map(fn {x1, y1} -> Enum.at(array, y1) |> Enum.at(x1) end)

        if length(coords_inside) == length(Enum.filter(coords_inside, fn val -> val > loc_value end)), do:
          [loc_value | acc2],
        else:
          acc2
      end)
    end )
    |> Enum.map(fn x -> x + 1 end)
    |> Enum.sum()
  end

  def solvePartB() do
    lines = Day9.getLines
    lines |> hd
  end

end

IO.inspect(Day9.solvePartA())
# IO.puts(Day9.solvePartB())
