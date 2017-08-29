defmodule GraphStage.ReceiptCreator do
  use GenStage
  require Logger

  def start_link(_args) do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [GraphStage.Producer]}
  end

  def handle_events(events, _from, state) do
    events_with_receipts =
      events
      |> Enum.map(fn e ->
        receipt_id = UUID.uuid1()
        Logger.info "Creating receipt: #{receipt_id}"
        Tuple.append(e, receipt_id)
      end)

    {:noreply, events_with_receipts, state}
  end

end

defmodule GraphStage.ReceiptUpdater do
  use GenStage
  require Logger

  def start_link(_args) do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [GraphStage.Parser]}
  end

  def handle_events(events, _from, state) do
    events
    |> Enum.each(fn {_ip, _payload, receipt_id} ->
      Logger.info "Updating receipt: #{receipt_id}"
    end)

    {:noreply, [], state}
  end

end
