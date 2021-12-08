defmodule Day8 do
  def getLines() do
    lines = File.read!("input/day8.txt")
    |> String.split("\n")

    Enum.map(lines, fn x -> String.split(x, "|") end)
  end

  def solvePartA() do
    lines = Day8.getLines
    Enum.reduce(lines, 0, fn line, acc ->
      [_, output] = line
      u = String.split(String.trim(output), " ")
        |> Enum.filter(fn x -> String.length(x) == 3 || String.length(x) == 7 || String.length(x) == 2 || String.length(x) == 4 end )
        |> length()
      acc + u
    end)
  end

  def solvePartB() do
    lines = Day8.getLines
    Enum.reduce(lines, 0, fn line, acc ->
      acc + calculateLine(line)
    end)
  end

  def calculateLine(line) do
    [input, output] = line

    nums = String.split(String.trim(input), " ")
    outputs = String.split(String.trim(output), " ")

    one = List.last(Enum.filter(nums, fn x -> String.length(x) == 2 end))
    seven = List.last(Enum.filter(nums, fn x -> String.length(x) == 3 end))
    four = List.last(Enum.filter(nums, fn x -> String.length(x) == 4 end ))
    eight = List.last(Enum.filter(nums, fn x -> String.length(x) == 7 end))

    # Can have the above in the output, but not the input, so need to match on length always
    # 2, 3, 5 have 5 segments
    # 0, 6, 9 have 6 segments

    Enum.map(outputs, fn output ->
      case String.length(output) do
        2 -> "1"
        3 -> "7"
        4 -> "4"
        5 -> case setDif(output, (if seven != nil, do: seven, else: one)) do
            2 -> "3"
            _ -> case setDif(output, four) do
              3 -> "2"
              _ -> "5"
            end
          end
        6 -> case setDif(output, one) do
          5 -> "6"
          _ -> case setDif(output, four) do
            2 -> "9"
            _ -> "0"
          end
        end
        7 -> "8"
      end
    end)
      |> Enum.join("")
      |> String.to_integer

  end

  # Gets length of set of chars in a not in b
  def setDif(a, b) do
    MapSet.difference(MapSet.new(String.graphemes(a)), MapSet.new(String.graphemes(b)))
      |> MapSet.size
  end

end

IO.puts(Day8.solvePartA())
IO.puts(Day8.solvePartB())
