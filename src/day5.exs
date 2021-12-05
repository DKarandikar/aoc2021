defmodule Day5 do
  def getLines() do
    File.read!("input/day5.txt") |> String.split("\n")
  end

  def incrementMapValue(map, key) do
    Map.put(map, key, 1 + Map.get(map, key, 0))
  end

  def gen_lines(x1, x2, y1, y2, map, diag_handler) do
    if x1 == x2, do:
      Enum.reduce(y1..y2, map, fn i, map -> Day5.incrementMapValue(map, {x1, i}) end),
    else:
      if y1 == y2, do:
        Enum.reduce(x1..x2, map, fn i, map -> Day5.incrementMapValue(map, {i, y1}) end),
      else:
        diag_handler.(x1, x2, y1, y2, map)
  end

  def calcIntersections(diag_handler) do
    lines = Day5.getLines

    coords = Enum.reduce(lines, %{}, fn line, acc ->
      [_ | captures] = Regex.run(~r/([0-9]+)\,([0-9]+) -> ([0-9]+)\,([0-9]+)/ , line)
      [x1, y1, x2, y2] = Enum.map(captures, &String.to_integer/1)

      Day5.gen_lines(x1, x2, y1, y2, acc, diag_handler)
    end
    )

    (:maps.filter fn _, v -> v > 1 end, coords)
      |> map_size
  end

  def solvePartA() do
    diag = fn _, _, _, _, z -> z end

    Day5.calcIntersections(diag)
  end

  def solvePartB() do
    diag = fn x1, x2, y1, y2, m ->
      Enum.reduce(Enum.zip(x1..x2, y1..y2), m, fn i, acc2 -> Day5.incrementMapValue(acc2, i) end)
    end

    Day5.calcIntersections(diag)
  end

end

IO.puts(Day5.solvePartA())
IO.puts(Day5.solvePartB())
