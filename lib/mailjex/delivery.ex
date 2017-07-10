defmodule Mailjex.Delivery do
  @moduledoc """
  Exposes functions for sending emails
  via MailJet.
  """
  use GenServer
  alias Mailjex.Api.Delivery
  @behaviour Mailjex.Behaviour.Delivery

  @doc false
  def start_link do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: __MODULE__])
  end

  ##########################
  # Public API
  ##########################

  @doc """
  Allows you to send a simple email
  via MailJet or send a transactional
  template email via MailJet.

  ## Examples

      iex> body = %{
      ...>  "FromEmail": "fromemail@gmail.com",
      ...>  "FromName": "Mailjet Pilot",
      ...>  "Subject": "Your email flight plan!",
      ...>  "MJ-TemplateID": "999902",
      ...>  "MJ-TemplateLanguage": true,
      ...>  "Vars": %{"name": "Alice"},
      ...>  "Recipients": [%{"Email": "toemail@gmail.com"}]
      ...>}
      iex> Mailjex.Delivery.send(body)
  """
  def send(body) do
    GenServer.call(__MODULE__, {:send, body})
  end

  ##########################
  # GenServer Callbacks
  ##########################

  def handle_call({:send, body}, _from, state) do
    {:reply, Delivery.send(body), state}
  end
end
