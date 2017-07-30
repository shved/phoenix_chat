defmodule PhoenixChat.Message do
  use PhoenixChat.Web, :model

  schema "messages" do
    field :body, :string
    field :timestamp, PhoenixChat.DateTime
    field :room, :string
    field :from, :string
    belongs_to :user, PhoenixChat.User

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :from, :room, :timestamp])
    |> validate_required([:body, :from, :room, :timestamp])
  end

  @doc """
  An `Ecto.Query` that returns the last 10 message records for a given room.
  """
  def latest_room_messages(room, number \\ 10) do
    from m in __MODULE__,
         where: m.room ==  ^room,
         order_by: [desc: :timestamp],
         limit: ^number
  end
end
