defmodule Day2 do
  def solve2a(lines) do
    rv = Enum.reduce(lines, {0, 0}, &Day2.acca/2)
    elem(rv, 0) * elem(rv, 1)
  end

  def acca(line, acc) do
    [dir | val] = String.split(line, " ")
    value = String.to_integer(val |> Enum.at(0))
    case dir do
      "forward" -> {elem(acc, 0) + value, elem(acc, 1)}
      "down" -> {elem(acc, 0), elem(acc, 1) + value}
      "up" -> {elem(acc, 0), elem(acc, 1) - value}
    end
  end

  def solve2b(lines) do
    rv = Enum.reduce(lines, {0, 0, 0}, &Day2.accb/2)
    elem(rv, 0) * elem(rv, 1)
  end

  def accb(line, acc) do
    [dir | val] = String.split(line, " ")
    value = String.to_integer(val |> Enum.at(0))
    case dir do
      "forward" -> {elem(acc, 0) + value, elem(acc, 1) + (value * elem(acc, 2)), elem(acc, 2)}
      "down" -> {elem(acc, 0), elem(acc, 1), elem(acc, 2) + value}
      "up" -> {elem(acc, 0), elem(acc, 1), elem(acc, 2) - value}
    end
  end

end

lines = String.split(File.read!("input/day2.txt"), "\n")

IO.puts(Day2.solve2a(lines))
IO.puts(Day2.solve2b(lines))
