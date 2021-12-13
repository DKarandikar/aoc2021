defmodule Day13 do
  def getFolds() do
    File.read!("input/day13fold.txt")
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, "fold along ") end)
      |> Enum.map(fn x -> Enum.at(x, 1) end)
      |> Enum.map(fn x -> String.split(x, "=") end)
      |> Enum.map(fn x -> {Enum.at(x, 0), String.to_integer(Enum.at(x, 1))} end)
  end

  def getDots() do
    File.read!("input/day13dot.txt") |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, ",") end)
      |> Enum.map(fn x -> {String.to_integer(Enum.at(x, 0)), String.to_integer(Enum.at(x, 1))} end)
      |> MapSet.new()
  end

  def solvePartA() do
    dots = getDots()
    first_fold = getFolds() |> hd
    doFold(dots, first_fold) |> MapSet.size()
  end

  def doFold(dots, {axis, number}) do
    loc = if axis == "y", do: 1, else: 0

    Enum.reduce(dots, MapSet.new(), fn dot, acc ->
      if elem(dot, loc) < number, do: (
        MapSet.put(acc, dot)
        ), else: (
          {x, y} = dot
          if loc == 1, do: (
            MapSet.put(acc, {x, (2*number) - y})
          ), else: (
            MapSet.put(acc, {(2*number) - x, y})
          )
      )
    end)

  end

  def solvePartB() do
    lines = Day13.getLines
    lines |> hd
  end

end

IO.inspect(Day13.solvePartA())
# IO.puts(Day13.solvePartB())
