defmodule Day2 do
  def parseLine(line) do
    [dir , val | _] = String.split(line, " ")
    {dir, String.to_integer(String.trim(val, "\n"))}
  end

  def solve2a(lines) do
    rv = Enum.reduce(lines, {0, 0}, &Day2.acca/2)
    elem(rv, 0) * elem(rv, 1)
  end

  def acca(line, acc) do
    {dir, value} = Day2.parseLine(line)

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
    {dir, value} = Day2.parseLine(line)

    case dir do
      "forward" -> {elem(acc, 0) + value, elem(acc, 1) + (value * elem(acc, 2)), elem(acc, 2)}
      "down" -> {elem(acc, 0), elem(acc, 1), elem(acc, 2) + value}
      "up" -> {elem(acc, 0), elem(acc, 1), elem(acc, 2) - value}
    end
  end

end

lines = File.stream!("input/day2.txt")

IO.puts(Day2.solve2a(lines))
IO.puts(Day2.solve2b(lines))
