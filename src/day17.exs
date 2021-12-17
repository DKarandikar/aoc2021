defmodule Day17 do
  def getInput() do
    line = File.read!("input/day17.txt") |> String.split("\n") |> hd
    [_ | captures] = Regex.run(~r/target area\: x\=([0-9]+)\.\.([0-9]+), y\=([-0-9]+)\.\.([-0-9]+)/ , line)
    Enum.map(captures, &String.to_integer/1)  # [xmin, xmax, ymin, ymax] =
  end

  def testMiss?(x, y) do
    [_, xmax, ymin, _] = getInput()
    x > xmax || y < ymin
  end

  def testHit?(x, y) do
    [xmin, xmax, ymin, ymax] = getInput()
    x >= xmin && x <= xmax && y >= ymin && y <= ymax
  end

  def evaluateStart(x, y) do
    Enum.reduce_while(Stream.cycle([0]), {0, 0, x, y, 0}, fn _, {xpos, ypos, xvel, yvel, highest} ->
      xpos = xpos + xvel
      ypos = ypos + yvel

      highest = if ypos > highest, do: ypos, else: highest

      xvel = if xvel > 0, do: xvel - 1, else: 0
      yvel = yvel - 1

      if testHit?(xpos, ypos), do: {:halt, highest}, else: (
        if testMiss?(xpos, ypos), do: {:halt, nil}, else: {:cont, {xpos, ypos, xvel, yvel, highest}}
      )

    end)
  end

  def getFiringBounds() do
    [xmin, xmax, ymin, ymax] = getInput()

    minimum_x = Enum.reduce_while(0..xmin, 0, fn i, _ ->
      minimum_x = div((i + 1) * i, 2)
      if minimum_x >= xmin, do: {:halt, i}, else: {:cont, 0}
    end)

    {minimum_x .. (xmax + 1), ymin .. abs(ymin)}

  end

  def solvePartA() do
    # evaluateStart(17, -4)
    {xrange, yrange} = getFiringBounds()

    Enum.reduce(xrange, 0, fn x, acc ->
      Enum.reduce(yrange, acc, fn y, acc2 ->
        z = evaluateStart(x, y)
        case z do
          nil -> acc2
          _ -> if z > acc2, do: z, else: acc2
        end
      end)
    end)
  end

  def solvePartB() do
    1
  end

end

IO.inspect(Day17.solvePartA())
# IO.puts(Day17.solvePartB())
