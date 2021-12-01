lines = String.split(File.read!("input/day1.txt"), "\n")

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
