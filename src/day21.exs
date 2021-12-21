defmodule Day21 do
  def getLines() do
    File.read!("input/day21.txt")
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, " ") |> Enum.at(-1) end)
      |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def incrementMapValue(map, key, val), do: Map.put(map, key, val + Map.get(map, key, 0))

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

  def quantum_roll() do
    # roll_score -> num universes
    %{3 => 1, 4 => 3, 5 => 6, 6 => 7, 7 => 6, 8 => 3, 9 => 1}
  end

  def do_quantum_step({p1_wins, p2_wins, universes}) do
    {p1pos, p2pos, p1s, p2s, p1_roll} = Map.keys(universes) |> Enum.sort(&(elem(&1, 3) <= elem(&2, 3))) |> Enum.at(0)
    IO.inspect({p1s, p2s})
    {num, universes} = Map.pop(universes, {p1pos, p2pos, p1s, p2s, p1_roll})

    rolls = quantum_roll()

    Enum.reduce(Map.keys(rolls), {p1_wins, p2_wins, universes}, fn roll_score, {p1w, p2w, us} ->
      # p1 to roll on even
      if p1_roll, do: (
        p1pos = do_move(p1pos, roll_score)
        p1s = p1s + p1pos
        num_universes = num * Map.get(rolls, roll_score)

        if p1s > 20, do: {p1w + num_universes, p2w, us}, else: {p1w, p2w, incrementMapValue(us, {p1pos, p2pos, p1s, p2s, false}, num_universes)}
      ), else: (

        p2pos = do_move(p2pos, roll_score)
        p2s = p2s + p2pos
        num_universes = num * Map.get(rolls, roll_score)

        if p2s > 20, do: (
          {p1w, p2w  + num_universes, us}
        ), else: {p1w, p2w, incrementMapValue(us, {p1pos, p2pos, p1s, p2s, true}, num_universes)}
      )
    end)

  end

  def solvePartB() do
    [p1, p2] = getLines()

    universes = %{{p1, p2, 0, 0, true} => 1}  # p1 pos, p2 pos, p1 score, p2 score, p1_roll

    state = {0, 0, universes}

    do_quantum_step(state)

    Enum.reduce_while(Stream.cycle([0]), state, fn _, state ->
      {p1, p2, us} = do_quantum_step(state)
      if Map.size(us) == 0, do: {:halt, {p1, p2}}, else: (
        # IO.puts(Map.size(us))
        {:cont, {p1, p2, us}}
      )
    end)
  end

end

IO.inspect(Day21.solvePartA())
# IO.inspect(Day21.solvePartB())
