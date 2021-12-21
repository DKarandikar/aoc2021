defmodule Day21 do
  def getLines() do
    File.read!("input/day21.txt")
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, " ") |> Enum.at(-1) end)
      |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def get_roll(n) do
    Enum.sum(Enum.map([0, 1, 2], fn x -> rem((n*3 + x), 100) + 1 end))
  end

  def do_move(pos, roll) do
    rem((pos - 1) + roll, 10) + 1
  end

  def solvePartA() do
    [p1, p2] = getLines()

    do_move(p1, get_roll(0))

    Enum.reduce_while(0..10000, {p1, p2, 0, 0, true}, fn roll, {p1, p2, p1_score, p2_score, p1_turn} ->

      if p1_turn, do: (
        p1 = do_move(p1, get_roll(roll))
        p1_score = p1_score + p1

        if p1_score > 999, do: {:halt, p2_score * (roll + 1) * 3}, else: {:cont, {p1, p2, p1_score, p2_score, false}}
      ), else: (
        p2 = do_move(p2, get_roll(roll))
        p2_score = p2_score + p2

        if p2_score > 999, do: {:halt, p1_score * (roll + 1) * 3}, else: {:cont, {p1, p2, p1_score, p2_score, true}}
      )
    end)

  end

  def solvePartB() do
    lines = Day21.getLines
    lines |> hd
  end

end

IO.inspect(Day21.solvePartA())
