defmodule Mailjex.Message do
  @moduledoc false
  use GenServer
  alias Mailjex.Api.Message
  @behaviour Mailjex.Behaviour.Message

  @doc false
  def start_link do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: __MODULE__])
  end

  # Public API

  def list(params \\ %{}) do
    GenServer.call(__MODULE__, {:list, params})
  end

  def history(params \\ %{}) do
    GenServer.call(__MODULE__, {:history, params})
  end

  def information(params \\ %{}) do
    GenServer.call(__MODULE__, {:information, params})
  end

  def sent_statistics(params \\ %{}) do
    GenServer.call(__MODULE__, {:sent_statistics, params})
  end

  def state(params \\ %{}) do
    GenServer.call(__MODULE__, {:state, params})
  end

  def statistics(params \\ %{}) do
    GenServer.call(__MODULE__, {:statistics, params})
  end

  # GenServer Callbacks

  def handle_call({:list, params}, _from, state) do
    {:reply, Message.list(params), state}
  end

  def handle_call({:history, params}, _from, state) do
    {:reply, Message.history(params), state}
  end

  def handle_call({:information, params}, _from, state) do
    {:reply, Message.information(params), state}
  end

  def handle_call({:sent_statistics, params}, _from, state) do
    {:reply, Message.sent_statistics(params), state}
  end

  def handle_call({:state, params}, _from, state) do
    {:reply, Message.state(params), state}
  end

  def handle_call({:statistics, params}, _from, state) do
    {:reply, Message.statistics(params), state}
  end
end
