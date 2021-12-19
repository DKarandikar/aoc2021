defmodule Day19 do

  def orientations() do
    [{1,1,1,0,1,2},{1,1,1,1,2,0},{1,1,1,2,0,1},{1,1,-1,2,1,0},{1,1,-1,1,0,2},
    {1,1,-1,0,2,1},{1,-1,-1,0,1,2},{1,-1,-1,1,2,0},{1,-1,-1,2,0,1},{1,-1,1,2,1,0},
    {1,-1,1,1,0,2},{1,-1,1,0,2,1},{-1,1,-1,0,1,2},{-1,1,-1,1,2,0},{-1,1,-1,2,0,1},
    {-1,1,1,2,1,0},{-1,1,1,1,0,2},{-1,1,1,0,2,1},{-1,-1,1,0,1,2},{-1,-1,1,1,2,0},
    {-1,-1,1,2,0,1},{-1,-1,-1,2,1,0},{-1,-1,-1,1,0,2},{-1,-1,-1,0,2,1}]
  end

  def parseInput() do
    File.read!("input/day19.txt")
      |> String.split("\n\n")
      |> Enum.map(fn ls -> String.split(ls, "\n") end)
      |> Enum.map(fn ls -> Enum.reduce(ls, MapSet.new(), fn x, acc ->
        if String.contains?(x, "---"), do: acc, else: (
          parts = String.split(x, ",")
          parts = Enum.map(parts, &String.to_integer/1)
          MapSet.put(acc, parts)
        )
      end)
    end)
  end

  def solve() do
    [beacons | rest] = parseInput()
    scanners = MapSet.new([[0, 0, 0]])

    # doStep({scanners, rest, beacons})

    {scanners, size} = Enum.reduce_while(Stream.cycle([0]), {scanners, rest, beacons}, fn _, {scanners, rest, beacons} ->
      {scanners, rest, beacons} = doStep({scanners, rest, beacons})
      if length(rest) == 0, do: {:halt, {scanners, MapSet.size(beacons)}}, else: {:cont, {scanners, rest, beacons}}
    end)

    {size, Enum.max((for i <- scanners, j <- scanners, i != j, do: mhd(i, j)))}
  end

  def doStep({scanners, rest, beacons}) do
    [scanner | rest] = rest

    r = for b1 <- beacons, into: %{}, do: {b1, (for b2 <- beacons, into: MapSet.new(), do: subtract(b1, b2))}

    z = find_rotation(scanner, r)

    if z == nil, do: {scanners, rest ++ [scanner], beacons}, else: (
      {p1, p2, rot} = z
      beacons = MapSet.union(beacons, (for s <- scanner, into: MapSet.new(), do: add(rotate(s, rot), subtract(p1, p2))))
      scanners = MapSet.put(scanners, add([0, 0, 0], subtract(p1, p2)))

      {scanners, rest, beacons}
    )

  end

  def find_rotation(scanner, r) do
    rots = rotations(scanner)
    Enum.reduce_while(Map.keys(rots), nil, fn key, _ ->
      rot_scanner = Map.get(rots, key)
      r1 = for b1 <- rot_scanner, into: %{}, do: {b1, (for b2 <- rot_scanner, into: MapSet.new(), do: subtract(b1, b2))}

      key_pairs = for i <- Map.keys(r), j <- Map.keys(r1), do: {i, j}
      r = Enum.reduce_while(key_pairs, nil, fn {i, j}, _ ->
        if MapSet.size(MapSet.intersection(Map.get(r, i), Map.get(r1, j))) > 11, do: {:halt, {i, j, key}}, else: {:cont, nil}
      end)
      if r != nil, do: {:halt, r}, else: {:cont, nil}
    end)
  end

  def subtract([x1, y1, z1], [x2, y2, z2]), do: [x1 - x2, y1 - y2, z1 - z2]
  def add([x1, y1, z1], [x2, y2, z2]), do: [x1 + x2, y1 + y2, z1 + z2]
  def mhd([x1, y1, z1], [x2, y2, z2]), do: abs(x1 - x2) + abs(y1 - y2) + abs(z1 - z2)
  def rotate(v, {a, b, c, i, j, k}), do: [a * Enum.at(v, i), b * Enum.at(v, j), c * Enum.at(v, k)]

  def rotations(scanner) do
    for orient <- orientations(), into: %{}, do: {orient, (for s <- scanner, into: MapSet.new(), do: rotate(s, orient))}
  end

  def solvePartB() do
    lines = Day19.getLines
    lines |> hd
  end

end

IO.inspect(Day19.solve())
