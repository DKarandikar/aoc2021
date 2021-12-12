defmodule Day12 do
  def getLines() do
    File.read!("input/day12.txt") |> String.split("\n")
  end

  def getGraph() do
    Enum.reduce(getLines(), %{}, fn line, acc ->
      [from, to | _ ] = String.split(line, "-")
      acc = Map.put(acc, from, MapSet.put(Map.get(acc, from, MapSet.new()), to))
      Map.put(acc, to, MapSet.put(Map.get(acc, to, MapSet.new()), from))
    end)

  end

  def upcase?(x), do: x == String.upcase(x)

  def getPaths(special_cave) do
    graph = getGraph()

    Enum.reduce_while(Stream.cycle([0]), {[["start"]], []}, fn _, {paths, comp} ->
      if length(paths) == 0, do: {:halt, comp}, else: (
        [path | paths] = paths
        neighbours = Map.get(graph, List.last(path))

        {new_paths, new_comps} = Enum.reduce(neighbours, {[], []}, fn neighbour, {ps, cs} ->
          if neighbour == "end", do: (
            {ps, cs ++ [path ++ [neighbour]]}
          ), else: (

            if upcase?(neighbour) || not Enum.member?(path, neighbour) || (special_cave == neighbour && Enum.count(path, &(&1 == neighbour)) == 1), do: (
              {ps ++ [path ++ [neighbour]], cs}
            ), else: (
              {ps, cs}
            )
          )
        end)

        {:cont, {paths ++ new_paths, comp ++ new_comps}}
      )
    end)

  end

  def solvePartA() do
    getPaths(nil) |> length
  end

  def solvePartB() do
    Enum.reduce(Map.keys(getGraph()), MapSet.new(), fn cave, set ->
      if not upcase?(cave) && cave != "start" && cave != "end", do: (
        MapSet.union(set, MapSet.new(getPaths(cave)))
      ), else: set
    end)
      |> MapSet.size()
  end

end

IO.inspect(Day12.solvePartA())
IO.puts(Day12.solvePartB())
