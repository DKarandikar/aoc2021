
defmodule Day3 do
  def size() do
    11
  end

  def getLines() do
    File.read!("input/day3.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day3.getLines
    res = Enum.reduce(lines, Enum.map(0..Day3.size, fn x -> 0 end), &Day3.acca/2)
    gamma = Enum.map(0..Day3.size, fn x -> if Enum.at(res, x) > length(lines)/2, do: "1", else: "0" end)
    epsilon = Enum.map(0..Day3.size, fn x -> if Enum.at(gamma, x) == "1", do: "0", else: "1" end)

    IO.inspect(res)
    IO.inspect(gamma)
    IO.inspect(epsilon)

    g = String.to_integer(List.to_string(gamma), 2)
    e = String.to_integer(List.to_string(epsilon), 2)
    g * e
  end

  def acca(line, acc) do
    v = Enum.map(0..Day3.size, fn x -> if String.at(line, x) == "1", do: 1, else: 0 end)
    Enum.map(Enum.zip(acc, v), fn x -> elem(x, 0) + elem(x, 1) end)
  end

  def solvePartB() do
    lines = Day3.getLines
    lines |> hd
  end

end

IO.inspect(Day3.solvePartA())
# IO.puts(Day3.solvePartB())
