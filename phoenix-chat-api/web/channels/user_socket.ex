defmodule PhoenixChat.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room:*", PhoenixChat.RoomChannel
  channel "admin:*", PhoenixChat.AdminChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(params, socket) do
    socket = socket
      |> assign(:user_id, params["id"])
      |> assign(:username, params["username"])
      |> assign(:email, params["email"])
      |> assign(:uuid, params["uuid"])
    {:ok, socket}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     PhoenixChat.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
