defmodule TridentWeb.ApiController do
  use TridentWeb, :controller

  def update(%{remote_ip: {a, b, c, d}} = conn, _params) do
    ip = ("#{a}.#{b}.#{c}.#{d}")
    {:ok, body, _conn} = Plug.Conn.read_body(conn)

    GraphStage.Producer.notify({ip, body})
    send_resp(conn, :ok, "")
  end
end
