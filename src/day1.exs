lines = String.split(File.read!("../input/day1.txt"), "\n")

defmodule Day1 do
  def acca(line, acc) do
    depth = Integer.parse(line)

    prev_depth = elem(acc, 0)
    so_far = elem(acc, 1)

    if prev_depth == :start, do: {depth, 0}, else: {depth, so_far + (if depth > prev_depth, do: 1, else: 0)}
  end

end

answ1a = Enum.reduce(lines, {:start, 0}, &Day1.acca/2)

IO.puts(elem(answ1a, 1))

range = Enum.to_list(0 .. ( length(lines) - 3 ))

answ1b = Enum.reduce(range, {:start, 0}, fn line_no, acc ->
  line0 = Enum.at(lines, line_no)
  line1 = Enum.at(lines, line_no + 1)
  line2 = Enum.at(lines, line_no + 2)

  three_depth = Enum.sum([String.to_integer(line0),  String.to_integer(line1), String.to_integer(line2)])

  prev_depth = elem(acc, 0)
  so_far = elem(acc, 1)

  if prev_depth == :start,
  do:
    {three_depth, 0},
  else:
    {three_depth, so_far + (if three_depth > prev_depth, do: 1, else: 0)}
  end
)

IO.puts(elem(answ1b, 1))
