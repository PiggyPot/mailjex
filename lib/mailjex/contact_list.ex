defmodule Mailjex.ContactList do
  @moduledoc """
  Exposes functions for managing contact lists on MailJet.
  """
  use GenServer
  alias Mailjex.Api.ContactList
  @behaviour Mailjex.Behaviour.ContactList

  @doc false
  def start_link do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: __MODULE__])
  end

  ##########################
  # Public API
  ##########################

  @doc """
  Allows you to manage the presence and subscription
  status of a contact to a specific contact list. 

  ## Examples

      iex> body = %{
      ...>    "Email": "mrsmith@mailjet.com",
      ...>    "Name": "MrSmith",
      ...>    "Action": "addnoforce",
      ...>    "Properties": %{
      ...>        "property1": "value",
      ...>        "propertyN": "valueN"
      ...>    }
      ...>}
      iex> Mailjex.ContactList.manage_contact(12345, body)
  """
  def manage_contact(id, body) do
    GenServer.call(__MODULE__, {:manage_contact, id, body})
  end

  ##########################
  # GenServer Callbacks
  ##########################

  def handle_call({:manage_contact, id, body}, _from, state) do
    {:reply, ContactList.manage_contact(id, body), state}
  end
end
