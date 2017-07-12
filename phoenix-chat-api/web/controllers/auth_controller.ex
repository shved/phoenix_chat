defmodule PhoenixChat.AuthController do
  use PhoenixChat.Web, :controller
  plug Ueberauth

  def test(conn, _params) do
    IO.puts "HIT"
    conn
  end
end
