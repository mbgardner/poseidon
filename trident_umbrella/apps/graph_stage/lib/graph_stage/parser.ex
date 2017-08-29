defmodule GraphStage.Parser do
  use GenStage
  import SweetXml
  require Logger

  def start_link(_args) do
    GenStage.start_link(__MODULE__, :dont_care, name: __MODULE__)
  end

  def init(_start_args) do
    {:producer_consumer, :dont_care, subscribe_to: [GraphStage.ReceiptCreator]}
  end

  def handle_events(events, _from, state) do
    events
    |> Enum.each(fn e ->
      result = parse_payload(e)
      Logger.info("Parsed payload: #{inspect result}")
    end)

    {:noreply, events, state}
  end

  def parse_payload({_uid, body, _receipt}) do
    xpath(body, ~x"//payload",
      uid: ~x"@uid",
      val_a: ~x".//val_a/text()",
      val_b: ~x".//val_b/text()"
    )
  end

end
