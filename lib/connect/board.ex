defmodule Connect.Board do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get_board(pid) do
    GenServer.call(pid, :show_board)
  end

  @impl true
  def init(:ok) do
    keys = for x <- 1..7,
      y <- 1..6, do: "#{x}.#{y}"
    board = Enum.reduce(keys, %{}, fn x, acc -> Map.put(acc, x, 0) end)
    board = Map.put(board, "1.1", 1)
      |> Map.put("2.1", 1)
      |> Map.put("3.1", 1)
      |> Map.put("4.1", 1)
    {:ok, board}
  end

  @impl true
  def handle_call(:show_board, _from, board) do
    {:reply, board, board}
  end

  def check_for_win(board, x, y) do

    keys = for x <- 1..7, do: "#{x}.#{y}"
    horiz = Enum.map(keys, &(Map.get(board, &1)))
      |> Enum.chunk_by(&(&1))
      |> Enum.map(&({length(&1), hd(&1)}))
      |> Enum.filter(fn {len, kind} -> kind != 0 and len >= 4 end)

    keys = for y <- 1..6, do: "#{x}.#{y}"
    vert = Enum.map(keys, &(Map.get(board, &1)))
      |> Enum.chunk_by(&(&1))
      |> Enum.map(&({length(&1), hd(&1)}))
      |> Enum.filter(fn {len, kind} -> kind != 0 and len >= 4 end)

    ## TODO diagonal
    # just generate the same set of keys
    # probably easy to use min/max

    wins = Enum.concat(horiz, vert)
    if length(wins) > 0 do
      {_, winner} = hd(wins)
      {:win, winner}
    else
      :no_win
    end
  end
end
