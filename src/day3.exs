
defmodule Day3 do
  def range(lines) do
    0 .. (String.length(hd lines) - 1)
  end

  def getLines() do
    File.read!("input/day3.txt") |> String.split("\n")
  end

  @doc """
  Get the bit which satisfies `f(total, length(lines)/2)` for column `index` of `lines`
  """
  def get_filtered_bit(index, lines, f) do
    v = Enum.map(lines, fn line -> if String.at(line, index) == "1", do: 1, else: 0 end)
    if f.(Enum.sum(v), length(lines) /2), do: "1", else: "0"
  end

  def solvePartA() do
    lines = Day3.getLines

    # The below generation of gamma is less efficient than summing all bits in one pass, then
    # generating based on those that are greater than len(lines)/2; but this is neat
    gamma = Enum.map(Day3.range(lines), fn x -> get_filtered_bit(x, lines, &(&1 >= &2)) end)

    epsilon = Enum.map(gamma, fn x -> if x == "1", do: "0", else: "1" end)

    g = String.to_integer(List.to_string(gamma), 2)
    e = String.to_integer(List.to_string(epsilon), 2)

    g * e
  end

  def solvePartB() do
    lines = Day3.getLines

    oxygen = do_bitwise_filtering(lines, &(&1 >= &2)) |> String.to_integer(2)
    co2 = do_bitwise_filtering(lines, &(&1 < &2)) |> String.to_integer(2)

    oxygen * co2
  end

  @doc """
  Take a list of lines which should be strings of 1s and 0s
  Take each column at a time, get the total number of 1s and keep lines
  for which `f(total, length(lines)/2)` is true
  Do this recursively until only one line is left
  """
  def do_bitwise_filtering(lines, f) do
    Enum.reduce_while(Day3.range(lines), lines, fn index, lines_acc ->
      column_bit_of_choice = Day3.get_filtered_bit(index, lines_acc, f)
      new_lines = Enum.filter(lines_acc, fn line -> String.at(line, index) == column_bit_of_choice end)

      if length(new_lines) == 1, do: {:halt, Enum.at(new_lines, 0)}, else: {:cont, new_lines}
    end
    )
  end

end

IO.puts(Day3.solvePartA())
IO.puts(Day3.solvePartB())
