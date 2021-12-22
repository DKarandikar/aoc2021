defmodule Day22 do
  def getLines() do
    File.read!("input/day22.txt") |> String.split("\n")
      |> Enum.map(fn x -> parseLine(x) end)
  end

  def parseLine(line) do
    [state, rest] = String.split(line, " ")


    [_ | captures] = Regex.run(~r/x=([-0-9]+)\.\.([-0-9]+)\,y=([-0-9]+)\.\.([-0-9]+)\,z=([-0-9]+)\.\.([-0-9]+)/, rest)
    [xmin, xmax, ymin, ymax, zmin, zmax] = Enum.map(captures, &String.to_integer/1)

    {(if state == "on", do: true, else: false), xmin, xmax, ymin, ymax, zmin, zmax}
  end

  def insideActivation?({_, xmin, xmax, ymin, ymax, zmin, zmax}) do
    (xmin < 51 && xmax > -51) && (ymin < 51 && ymax > -51) && (zmin < 51 && zmax > -51)
  end

  def solvePartA() do
    getLines()
      |> Enum.filter(&insideActivation?/1)
      |> Enum.reduce({MapSet.new(), MapSet.new()}, fn {turn_on, xmin, xmax, ymin, ymax, zmin, zmax}, {on, off} ->
        to_turn = for x <- xmin..xmax, y <- ymin..ymax, z <- zmin..zmax, x < 51, x > -51, y < 51, y > -51, z < 51, z > -51, into: MapSet.new(), do: {x, y, z}
        if turn_on, do: (
          on = MapSet.union(on, to_turn)
          off = MapSet.difference(off, to_turn)
          {on, off}
        ), else: (
          off = MapSet.union(off, to_turn)
          on = MapSet.difference(on, to_turn)
          {on, off}
        )

      end)
      |> count()
  end

  def count({x, y}), do: {MapSet.size(x), MapSet.size(y)}

  def solvePartB() do
    lines = Day22.getLines
    lines |> hd
  end

end

IO.inspect(Day22.solvePartA())
# IO.puts(Day22.solvePartB())
