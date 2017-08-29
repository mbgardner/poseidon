defmodule TidalWave do
  import XmlBuilder
  require Logger

  @default_processes 10
  @sleep_range 1..10

  def main(args) do
    Logger.info "Starting TidalWave"

    opts = process_args(args)
    1..(Keyword.get(opts, :processes, @default_processes))
    |> Enum.each(fn _n -> spawn_sender() end)

    Process.sleep(:infinity)
  end

  def process_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [processes: :integer])
    options
  end

  def spawn_sender do
    uid = UUID.uuid1()
    spawn(fn -> loop(uid) end)
  end

  def loop(uid) do
    send_payload(uid)
    Logger.info "#{uid} -- sending payload"

    @sleep_range
    |> Enum.random()
    |> (&(&1 * 1000)).()
    |> Process.sleep()

    loop(uid)
  end

  def send_payload(uid) do
    payload = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>" <> good_payload(uid)
    HTTPoison.post "http://localhost:4000/api/update", payload, [{"Content-Type", "text/xml"}]
  end

  # send a bad payload 10% of the time
  def get_payload(uid) do
    case :rand.uniform(10) do
      0 -> bad_payload(uid)
      _ -> good_payload(uid)
    end
  end

  def good_payload(uid) do
    element(:payload, %{uid: uid}, [
      element(:val_a, "aaa"),
      element(:val_b, "bbb"),
    ])
    |> generate
  end

  def bad_payload(uid) do
    "<payload uid=#{uid}><"
  end

end
