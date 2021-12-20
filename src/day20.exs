defmodule Day20 do
  def getInput() do
    [enhancement, image] = File.read!("input/day20.txt") |> String.split("\n\n")
    image_lines = String.split(image, "\n") |> Enum.map(fn x -> String.graphemes(x) end)
    maxX = length(image_lines) - 1
    maxY = length(Enum.at(image_lines, 0)) - 1
    map = for y <- 0 .. maxX , x <- 0 .. maxY, into: %{}, do: {{x, y}, (if getElem(image_lines, x, y) == "#", do: 1, else: 0)}
    {enhancement, map, 0, 0, maxX, maxY, 0}
  end

  def getElem(lines, x, y), do: lines |> Enum.at(y) |> Enum.at(x)

  def solve() do
    steps2 = getInput() |> enchance() |> enchance()
    IO.puts(steps2 |> count())

    steps50 = Enum.reduce(0..47, steps2, fn _, acc ->
      enchance(acc)
    end)

    IO.puts(steps50 |> count())

  end

  def count({_, image, _, _, _, _, _}) do
    Map.values(image)
      |> Enum.filter(fn x -> x == 1 end)
      |> length()
  end

  def print({_, image, minX, minY, maxX, maxY, _}) do
    Enum.reduce(minY .. maxY, [], fn y, acc ->
      acc ++ [Enum.reduce(minX .. maxX, [], fn x, acc2 ->
        acc2 ++ [(if Map.get(image, {x, y}) == 1, do: "#", else: ".")]
      end)]
    end)
      |> Enum.join("\n")
  end

  def enchance({enhancement, image, minX, minY, maxX, maxY, count}) do
    new_image = for y <- (minY - 1) .. (maxY + 1), x <- (minX - 1) .. (maxX + 1), into: %{}, do: {{x, y}, getPixel(enhancement, image, x, y, count)}
    {enhancement, new_image, minX - 1, minY - 1, maxX + 1, maxY + 1, count + 1}
  end

  def getPixel(enhancement, image, x, y, count) do
    order = [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {0, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]

    borders = if rem(count, 2) == 1, do: 1, else: 0

    num = Enum.map(order, fn {x1, y1} -> Integer.to_string(Map.get(image, {x + x1, y+ y1}, borders)) end)
      |> Enum.join()
      |> Integer.parse(2)
      |> elem(0)

    if String.at(enhancement, num) == "#", do: 1, else: 0
  end

end

Day20.solve()
