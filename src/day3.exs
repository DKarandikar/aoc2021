
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

    oxygen = Enum.reduce_while(0..Day3.size, lines, &Day3.accb/2)
    co2 = Enum.reduce_while(0..Day3.size, lines, &Day3.accb2/2)

    g = String.to_integer(oxygen, 2)
    e = String.to_integer(co2, 2)
    g * e
  end

  def accb(index, lines) do
    most_common = Day3.get_most_common(index, lines)
    new_lines = Enum.filter(lines, fn line -> String.at(line, index) == most_common end)

    if length(new_lines) == 1, do: {:halt, Enum.at(new_lines, 0)}, else: {:cont, new_lines}
  end

  def accb2(index, lines) do
    least_common = Day3.get_least_common(index, lines)
    new_lines = Enum.filter(lines, fn line -> String.at(line, index) == least_common end)

    if length(new_lines) == 1, do: {:halt, Enum.at(new_lines, 0)}, else: {:cont, new_lines}
  end

  def get_most_common(index, lines) do
    v = Enum.map(lines, fn line -> if String.at(line, index) == "1", do: 1, else: 0 end)
    if Enum.sum(v) >= length(lines) /2, do: "1", else: "0"
  end

  def get_least_common(index, lines) do
    v = Enum.map(lines, fn line -> if String.at(line, index) == "1", do: 1, else: 0 end)
    if Enum.sum(v) < length(lines) /2, do: "1", else: "0"
  end

end

# IO.inspect(Day3.solvePartA())
IO.puts(Day3.solvePartB())
