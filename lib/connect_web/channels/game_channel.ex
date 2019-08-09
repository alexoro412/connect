defmodule ConnectWeb.GameChannel do
  use Phoenix.Channel

  def join("connect:board", _message, socket) do
    {:ok, socket}
  end

  def handle_in("play", %{"column" => column}, socket) when is_number(column) and 1 <= column and column <= 7 do
    broadcast!(socket, "play", %{"column" => column})
    {:noreply, socket}
  end

  def handle_in("play", %{}, socket) do
    {:noreply, socket}
  end
end
