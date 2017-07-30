defmodule PhoenixChat.UserSocket do
  use Phoenix.Socket
  alias PhoenixChat.{Repo, User}

  ## Channels
  channel "room:*", PhoenixChat.RoomChannel
  channel "admin:*", PhoenixChat.AdminChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(params, socket) do
    user_id = params["id"]
    user = user_id && Repo.get(User, user_id)
    validate_params!(params)

    socket = if user do
        socket
        |> assign(:user_id, user_id)
        |> assign(:username, user.username)
        |> assign(:email, user.email)
      else
        socket
        |> assign(:uuid, params["uuid"])
      end

    {:ok, socket}
  end

  @empty ["", nil]
  defp validate_params!(%{"id" => id, "uuid" => uuid})
  when id in @empty or uuid in @empty do
    raise "id or uuid must not be empty"
  end

  defp validate_params!(_), do: nil

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
