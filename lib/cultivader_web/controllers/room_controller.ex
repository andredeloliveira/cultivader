defmodule CultivaderWeb.RoomController do
  use CultivaderWeb, :controller

  alias Cultivader.Environment
  alias Cultivader.Environment.Room

  action_fallback CultivaderWeb.FallbackController

  def index(conn, _params) do
    rooms = Environment.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- Environment.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", room_path(conn, :show, room))
      |> render("show.json", room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Environment.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Environment.get_room!(id)

    with {:ok, %Room{} = room} <- Environment.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Environment.get_room!(id)
    with {:ok, %Room{}} <- Environment.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
