defmodule GraphStage.Producer do
  use GenStage
  require Logger

  def start_link(initial \\ []) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def init(counter) do
    Logger.info "Starting GraphStage.Producer"
    {:producer, counter}
  end

  def notify(event) do
    GenStage.call(__MODULE__, {:notify, [event]})
  end

  def handle_call({:notify, events}, _from, state) do
    IO.puts "\n\n***\n\n#{inspect state}\n\n***\n\n"
    {:reply, :ok, events, state}
  end

  def handle_demand(demand, state) do
    events = []
    {:noreply, events, state}
  end

end
