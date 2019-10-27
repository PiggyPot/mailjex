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


  @doc """
  Allows you to manage the presence and subscription
  status of a contact to a specific contact list.

  ## Examples

      iex> body = %{
      ...>    "Action": "addnoforce",
      ...>    "Contacts": [
      ...>        "Email": "mrsmith@mailjet.com",
      ...>        "Name": "MrSmith",
      ...>        "IsExcludedFromCapaign": false,
      ...>        "Properties": %{
      ...>            "property1": "value",
      ...>            "propertyN": "valueN"
      ...>        }
      ...>    ]
      ...>}
      iex> Mailjex.ContactList.manage_many_contacts_in_list(12345, body)
  """
  def manage_many_contacts_in_list(list_id, body) do
    GenServer.call(__MODULE__, {:manage_many_contacts_in_list, list_id, body})
  end


  @doc """
  Allows you to create a contact list. When is_deleted is true, the contact list will be marked as Deleted. Deleted lists can later be reinstated by updating this value to False.

  ## Examples

      iex> name = "testing"
      iex> is_deleted = false
      iex> Mailjex.ContactList.create_contact_list(name, is_deleted)
  """
  def create_contact_list(name, is_deleted = false) do
    GenServer.call(__MODULE__, {:create_contact_list, name, is_deleted})
  end

  @doc """
  Retrieve details for all contact lists - name, subscriber count, creation timestamp, deletion status. Options available here: https://dev.mailjet.com/email/reference/contacts/contact-list/#v3_get_contactslist

  ## Examples

      iex> Mailjex.ContactList.get_all_contact_lists()
  """
  def get_all_contact_lists(options \\ []) do
    GenServer.call(__MODULE__, {:get_all_contact_lists, options})
  end

  @doc """
  Retrieve details for a specific contact list - name, subscriber count, creation timestamp, deletion status.

  ## Examples

      iex> Mailjex.ContactList.get_contact_list(12345)
  """
  def get_contact_list(list_id, options \\ []) do
    GenServer.call(__MODULE__, {:get_contact_list, list_id, options})
  end

  @doc """
  Update a specific contact list by changing its name and / or deletion status. Using PUT you can delete lists, as well as reinstate previously deleted ones.

  ## Examples

      iex> body = %{
      ...>  "IsDeleted": false,
      ...>  "Name": "testing"
      ...>}
      iex> Mailjex.ContactList.update_contact_list(12345, body)
  """
  def update_contact_list(list_id, body) do
    GenServer.call(__MODULE__, {:update_contact_list, list_id, body})
  end

  @doc """
  Delete a contact list. The ContactsList object will continue to exist with Deleted status for 30 days, and can be reinstated by changing the value of IsDeleted to false via PUT /contactslist/{list_ID}.

  ## Examples

      iex> Mailjex.ContactList.manage_contact(12345)
  """
  def delete_contact_list(list_id, options \\ []) do
    GenServer.call(__MODULE__, {:delete_contact_list, list_id, options})
  end

  ##########################
  # GenServer Callbacks
  ##########################

  def handle_call({:manage_contact, id, body}, _from, state) do
    {:reply, ContactList.manage_contact(id, body), state}
  end

  def handle_call({:manage_contacts_in_list, list_id, body}, _from, state) do
    {:reply, ContactList.manage_contacts_in_list(list_id, body), state}
  end

  def handle_call({:create_contact_list, name, is_deleted}, _from, state) do
    {:reply, ContactList.create_contact_list(name, is_deleted), state}
  end

  def handle_call({:get_all_contact_lists, options}, _from, state) do
    {:reply, ContactList.get_all_contact_lists(options), state}
  end

  def handle_call({:get_contact_list, list_id, options}, _from, state) do
    {:reply, ContactList.get_contact_list(list_id, options), state}
  end

  def handle_call({:delete_contact_list, list_id, options}, _from, state) do
    {:reply, ContactList.delete_contact_list(list_id, options), state}
  end

  def handle_call({:update_contact_list, list_id, body}, _from, state) do
    {:reply, ContactList.update_contact_list(list_id, body), state}
  end

end
