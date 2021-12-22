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

  def removeOverlap({xmin, xmax, ymin, ymax, zmin, zmax}, cubes) do
    Enum.reduce(cubes, cubes, fn {xmin2, xmax2, ymin2, ymax2, zmin2, zmax2}, cubes ->
      minX = max(xmin, xmin2)
      maxX = min(xmax, xmax2)
      minY = max(ymin, ymin2)
      maxY = min(ymax, ymax2)
      minZ = max(zmin, zmin2)
      maxZ = min(zmax, zmax2)

      if (minX <= maxX) && (minY <= maxY) && (minZ <= maxZ), do: (
        cubes = MapSet.delete(cubes, {xmin2, xmax2, ymin2, ymax2, zmin2, zmax2})
        {cubes, xmin2} = if (xmin2 <= minX) && (minX <= xmax2), do: {MapSet.put(cubes, {xmin2, minX - 1, ymin2, ymax2, zmin2, zmax2}), minX}, else: {cubes, xmin2}
        {cubes, xmax2} = if (xmin2 <= maxX) && (maxX <= xmax2), do: {MapSet.put(cubes, {maxX + 1, xmax2, ymin2, ymax2, zmin2, zmax2}), maxX}, else: {cubes, xmax2}

        {cubes, ymin2} = if (ymin2 <= minY) && (minY <= ymax2), do: {MapSet.put(cubes, {xmin2, xmax2, ymin2, minY - 1, zmin2, zmax2}), minY}, else: {cubes, ymin2}
        {cubes, ymax2} = if (ymin2 <= maxY) && (maxY <= ymax2), do: {MapSet.put(cubes, {xmin2, xmax2, maxY + 1, ymax2, zmin2, zmax2}), maxY}, else: {cubes, ymax2}

        {cubes, zmin2} = if (zmin2 <= minZ) && (minZ <= zmax2), do: {MapSet.put(cubes, {xmin2, xmax2, ymin2, ymax2, zmin2, minZ - 1}), minZ}, else: {cubes, zmin2}
        if (zmin2 <= maxZ) && (maxZ <= zmax2), do: MapSet.put(cubes, {xmin2, xmax2, ymin2, ymax2, maxZ + 1, zmax2}), else: cubes

      ), else: cubes
    end)
  end

  def solvePartB() do
    lines = getLines()
    {_, xmin, xmax, ymin, ymax, zmin, zmax} = lines |> hd

    cubes = Enum.reduce(
      lines |> tl,
      MapSet.new([{xmin, xmax, ymin, ymax, zmin, zmax}]),
      fn {turn_on, xmin, xmax, ymin, ymax, zmin, zmax}, cubes ->
        # Remove the overlap of new cubes with all old ones, and then add it if it's on
        cubes = removeOverlap({xmin, xmax, ymin, ymax, zmin, zmax}, cubes)
        if turn_on, do: MapSet.put(cubes, {xmin, xmax, ymin, ymax, zmin, zmax}), else: cubes
    end)

    Enum.sum(Enum.map(cubes, fn {xmin, xmax, ymin, ymax, zmin, zmax} -> ((xmax + 1 - xmin) * (ymax + 1 - ymin) * (zmax + 1 - zmin))end))

  end

end

IO.inspect(Day22.solvePartA())
IO.inspect(Day22.solvePartB())
