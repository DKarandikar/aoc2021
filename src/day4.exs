
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

  def solvePartA() do
    lines = Day4.getLines
    [nums | boards ] = lines
    boards = boards
      |> Enum.chunk_every(6)
      |> Enum.map(&Board.fromLines/1)

    num_boards = length(boards) - 1

    boards = for i <- 0..length(boards) - 1, into: %{}, do: {i, Enum.at(boards, i)}

    nums = Enum.map(String.split(nums, ","), fn l -> String.to_integer(l) end)

    winner = Enum.reduce_while(0..length(nums), boards,  fn num_index, num_acc ->

      boards = for i <- 0..num_boards, into: %{}, do: {i, Board.remove(Map.get(num_acc, i), Enum.at(nums, num_index))}

      winner = Enum.reduce_while( 0.. num_boards, nil, fn i, acc ->
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
    lines = Day4.getLines
    lines |> hd
  end

end

IO.inspect(Day4.solvePartA())
# IO.puts(Day4.solvePartB())
