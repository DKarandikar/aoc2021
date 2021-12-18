defmodule Day18 do
  def getLines() do
    File.read!("input/day18.txt") |> String.split("\n")
  end

  def parseLine(line) do
    Enum.reduce(String.graphemes(line), {0, []}, fn char, {level, acc} ->
      case char do
        "[" -> {level + 1, acc}
        "]" -> {level - 1, acc}
        "," -> {level, acc}
        _ -> {level, acc ++ [{String.to_integer(char), level}]}
      end
    end)
    |> elem(1)
  end

  def incrementLevel({x, l}) do
    {x, l + 1}
  end

  def add(num1, num2) do
    Enum.map(num1, &incrementLevel/1) ++ Enum.map(num2, &incrementLevel/1)
  end

  def explode(num) do
    i = Enum.find_index(num, fn {_, l} -> l >= 5 end)
    if i == nil, do: nil, else: (

      first_num = Enum.at(num, i) |> elem(0)
      level = Enum.at(num, i) |> elem(1)
      second_num = Enum.at(num, i + 1) |> elem(0)

      start = if i == 0, do: [], else: Enum.slice(num, 0.. i - 1) |> Enum.reverse()
      end_ = Enum.slice(num, i + 2 .. length(num) - 1)

      start = if length(start) == 0, do: start, else: (
        {x, l} = hd(start)
        [{x + first_num, l}] ++ tl(start)
      ) |> Enum.reverse()

      end_ = if length(end_) == 0, do: end_, else: (
        {x, l} = hd(end_)
        [{x + second_num, l}] ++ tl(end_)
      )

      start ++ [{0, level - 1}] ++ end_
    )
  end

  def split(num) do
    i = Enum.find_index(num, fn {x, _} -> x >= 10 end)
    if i == nil, do: nil, else: (

      first_num = Enum.at(num, i) |> elem(0)
      level = Enum.at(num, i) |> elem(1)

      down = div(first_num, 2)
      up = first_num - down

      start = if i == 0, do: [], else: Enum.slice(num, 0.. i - 1)
      end_ = Enum.slice(num, i + 1 .. length(num) - 1)

      start ++ [{down, level + 1}, {up, level + 1}] ++ end_
    )
  end

  def reduce(num) do
    Enum.reduce_while(Stream.cycle([0]), num, fn _, acc ->
      e = explode(acc)
      if e != nil, do: {:cont, e}, else: (
        s = split(acc)
        if s != nil, do: {:cont, s}, else: {:halt, acc}
      )
    end)
  end

  def magnitude([{x, l}]), do: x

  def magnitude(num) do
    i = Enum.zip(num, Enum.slice(num, 1 .. length(num) - 1))
      |> Enum.find_index(fn {{x1, l1}, {x2, l2}} -> l1 == l2 end)

    first_num = Enum.at(num, i) |> elem(0)
    level = Enum.at(num, i) |> elem(1)
    second_num = Enum.at(num, i + 1) |> elem(0)

    start = if i == 0, do: [], else: Enum.slice(num, 0.. i - 1)
    end_ = Enum.slice(num, i + 2 .. length(num) - 1)

    magnitude(start ++ [{first_num * 3 + second_num * 2, level - 1}] ++ end_)
  end

  def solvePartA() do
    start = Day18.getLines
      |> hd |> parseLine()

    Enum.reduce(tl(getLines()), start, fn line, acc ->
      add(acc, parseLine(line)) |> reduce()
    end)
      |> magnitude()
  end

  def solvePartB() do
    lines = Day18.getLines
    lines |> hd
  end

end

IO.inspect(Day18.solvePartA())
# IO.puts(Day18.solvePartB())
