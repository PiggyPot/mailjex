defmodule Mailjex.Template do
  @moduledoc """
  Retrieve useful information about templates
  stored in your MailJet account.
  """
  use GenServer
  alias Mailjex.Api.Template
  @behaviour Mailjex.Behaviour.Template

  @doc false
  def start_link do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: __MODULE__])
  end

  ##########################
  # Public API
  ##########################

  def list(params \\ %{}) do
    GenServer.call(__MODULE__, {:list, params})
  end

  ##########################
  # GenServer Callbacks
  ##########################

  def handle_call({:list, params}, _from, state) do
    {:reply, Template.list(params), state}
  end
end
