defmodule Mailjex.Contact do
  @moduledoc """
  Exposes functions for managing contacts on MailJet.
  """
  use GenServer
  alias Mailjex.Api.Contact
  @behaviour Mailjex.Behaviour.Contact

  @doc false
  def start_link do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: __MODULE__])
  end

  ##########################
  # Public API
  ##########################

  @doc """
  Allows you to create a contact on MailJet

  ## Examples

      iex> body = %{
      ...>  "Email": "contactemail@gmail.com",
      ...>}
      iex> Mailjex.Contact.create(body)
  """
  def create(body) do
    GenServer.call(__MODULE__, {:create, body})
  end

  @doc """
  Allows you to view a contact on MailJet

  ## Examples

      iex> Mailjex.Contact.view("1234ID")
  """
  def view(id) do
    GenServer.call(__MODULE__, {:view, id})
  end

  @doc """
  Allows you to list contacts on MailJet

  ## Examples

      iex> Mailjex.Contact.list()
  """
  def list do
    GenServer.call(__MODULE__, {:list})
  end

  @doc """
  Allows you to update a contact on MailJet

  ## Examples

      iex> body = %{
      ...>  "Email": "contactemail@gmail.com",
      ...>}
      iex> Mailjex.Contact.update("1234ID", body)
  """
  def update(id, body) do
    GenServer.call(__MODULE__, {:update, id, body})
  end

  @doc """
  Allows you to manage what contact lists
  a given contact is on.

  ## Examples

      iex> body = %{
      ...>  "ContactsLists": [%{"ListID": 1684490, "Action": "addnoforce"}],
      ...>}
      iex> Mailjex.Contact.manage_contacts_lists(12345, body)
  """
  def manage_contacts_lists(id, body) do
    GenServer.call(__MODULE__, {:manage_contacts_lists, id, body})
  end

  @doc """

  Allows you to retrieve all contact lists
  for a specific contact

  ## Examples

      iex> Mailjex.Contact.get_contacts_lists("1234ID")
  """
  def get_contacts_lists(id) do
    GenServer.call(__MODULE__, {:get_contacts_lists, id})
  end

  ##########################
  # GenServer Callbacks
  ##########################

  def handle_call({:create, body}, _from, state) do
    {:reply, Contact.create(body), state}
  end

  def handle_call({:view, id}, _from, state) do
    {:reply, Contact.view(id), state}
  end

  def handle_call({:list}, _from, state) do
    {:reply, Contact.list(), state}
  end

  def handle_call({:update, id, body}, _from, state) do
    {:reply, Contact.update(id, body), state}
  end

  def handle_call({:manage_contacts_lists, id, body}, _from, state) do
    {:reply, Contact.manage_contacts_lists(id, body), state}
  end

  def handle_call({:get_contacts_lists, id}, _from, state) do
    {:reply, Contact.get_contacts_lists(id), state}
  end
end
