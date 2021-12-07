defmodule Day7 do

  def getNums() do
    File.read!("input/day7.txt")
      |> String.split("\n")
      |> hd
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
  end

  def getMinMovement(cost_fn) do
    nums = getNums()

    getMovementCost = &(
      nums
        |> Enum.map(fn n -> cost_fn.(&1, n) end)
        |> Enum.sum()
    )

    nums
      |> genRange()
      |> Enum.map(getMovementCost)
      |> Enum.min()
  end

  def genRange(nums), do: Enum.min(nums) .. Enum.max(nums)

  def solvePartA(), do: getMinMovement(&pAcost/2)
  def solvePartB(), do: getMinMovement(&pBcost/2)

  def pAcost(a, b), do: abs(a-b)
  def pBcost(a, b), do: div(abs(a-b) * (abs(a-b)+1), 2)

end

IO.puts(Day7.solvePartA())
IO.puts(Day7.solvePartB())
