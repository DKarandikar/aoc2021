defmodule Day7 do
  def getNums() do
    File.read!("input/day7.txt") |> String.split("\n")
      |> hd
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
  end

  def getMinMovement(cost_fn) do
    nums = getNums()

    nums
      |> (&(Enum.min(&1)..Enum.max(&1))).()
      |> Enum.map(
        fn i ->
          nums
            |> Enum.map(fn n -> cost_fn.(abs(n-i)) end)
            |> Enum.sum()
        end
        )
      |> Enum.min()
  end

  def solvePartA() do
    getMinMovement(&(&1))
  end

  def solvePartB() do
    getMinMovement(&(genCost(&1)))
  end

  def genCost(x) do
    if x == 0, do: 0, else: Enum.sum(1..x)
  end

end

IO.puts(Day7.solvePartA())
IO.puts(Day7.solvePartB())
