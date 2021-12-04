
defmodule Board do
  defstruct [:rows, :columns]

  def fromLines(lines) do
    [_ | lines] = lines
    rows = lines
      |> Enum.map(fn line -> Enum.map(String.split(line, " ", trim: true), fn l -> String.to_integer(l) end) end)

    columns = Enum.map(0..4, fn x -> Enum.map(rows, fn row -> Enum.at(row, x) end) end)

    %Board{rows: rows, columns: columns}
  end

  def remove(board, number) do
    rows = Enum.map(board.rows, fn l -> List.delete(l, number) end)
    columns = Enum.map(board.columns, fn l -> List.delete(l, number) end)
    %Board{rows: rows, columns: columns}
  end

  def is_winner?(board) do
    Enum.any?(board.rows, fn x -> length(x) == 0 end) || Enum.any?(board.columns, fn x -> length(x) == 0 end)
  end

  def score(board) do
    Enum.sum(Enum.map(board.rows, fn row -> Enum.sum(row) end))
  end
end

defmodule Day4 do
  def getLines() do
    File.read!("input/day4.txt") |> String.split("\n")
  end

  def getNumsBoards() do
    lines = Day4.getLines
    [nums | boards ] = lines
    boards = boards
      |> Enum.chunk_every(6)
      |> Enum.map(&Board.fromLines/1)

    boards = for i <- 0..length(boards) - 1, into: %{}, do: {i, Enum.at(boards, i)}

    nums = Enum.map(String.split(nums, ","), fn l -> String.to_integer(l) end)

    {nums, boards}
  end

  def removeNumberFromBoards(boards, number) do
    for i <- 0..Enum.max(Map.keys(boards)), Map.get(boards, i) != nil,
      into: %{},
      do: {
        i,
        Board.remove(Map.get(boards, i), number)
      }
  end

  def solvePartA() do
    {nums, boards} = Day4.getNumsBoards
    num_boards = map_size(boards) - 1

    winner = Enum.reduce_while(0..length(nums), boards,  fn num_index, num_acc ->
      boards = removeNumberFromBoards(num_acc, Enum.at(nums, num_index))

      winner = Enum.reduce_while(0.. num_boards, nil, fn i, _ ->
        board = Map.get(boards, i)
        if Board.is_winner?(board), do:
          {:halt, board}, else:
          {:cont, nil}
      end
      )

      if winner == nil, do:
        {:cont, boards}, else:
        {:halt, {winner, Enum.at(nums, num_index)}}

    end
    )

    Board.score(winner |> elem(0)) * (winner |> elem(1))

  end

  def solvePartB() do
    {nums, boards} = Day4.getNumsBoards

    result = Enum.reduce_while(0..length(nums), boards,  fn num_index, num_acc ->
      boards = removeNumberFromBoards(num_acc, Enum.at(nums, num_index))

      new_boards = :maps.filter fn _, v -> Board.is_winner?(v) == :false end, boards

      if map_size(new_boards) != 1, do:
        {:cont, new_boards}, else:
        {:halt, {Map.get(new_boards, Enum.random(Map.keys(new_boards))), Enum.at(nums, num_index + 1)}}

    end
    )

    last_num = result |> elem(1)
    Board.score(Board.remove(result |> elem(0), last_num)) * last_num

  end

end

IO.puts(Day4.solvePartA())
IO.puts(Day4.solvePartB())
