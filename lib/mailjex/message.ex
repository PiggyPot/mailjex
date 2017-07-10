defmodule Mailjex.Message do
  @moduledoc """
  Retrieve useful information about messages
  (emails) processed by MailJet.
  """
  
  use GenServer
  alias Mailjex.Api.Message
  @behaviour Mailjex.Behaviour.Message

  @doc false
  def start_link do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: __MODULE__])
  end

  ##########################
  # Public API
  ##########################

  @doc """
  List information on all messages that
  have been sent via MailJet. Note, filters
  can be passed to this function as a 
  optional map parameter i.e. 
  `.list(%{Campaign: 9999850})`.

  ## Examples

      iex> Mailjex.Message.list
      {:ok,
      %{"Count" => 1,
        "Data" => [%{"ArrivedAt" => "2017-07-08T22:28:38Z", "AttachmentCount" => 0,
          "AttemptCount" => 0, "CampaignID" => 9999849, "ContactID" => 9999649449,
          "Delay" => 510, "DestinationID" => 2, "FilterTime" => 102,
          "ID" => 99999042389999999, "IsClickTracked" => false,
          "IsHTMLPartIncluded" => true, "IsOpenTracked" => true,
          "IsTextPartIncluded" => false, "IsUnsubTracked" => false,
          "MessageSize" => 12794, "SenderID" => 9999974051, "SpamassRules" => "",
          "SpamassassinScore" => 0, "StatePermanent" => false,
          "Status" => "opened"}], "Total" => 1}}
  """
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

  ##########################
  # GenServer Callbacks
  ##########################

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
