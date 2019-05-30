defmodule Mailjex.Send do
  @moduledoc """
  Exposes functions for managing contacts on MailJet.
  """
  use GenServer
  alias Mailjex.Api.Send
  @behaviour Mailjex.Behaviour.Send

  @doc false
  def start_link do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: __MODULE__])
  end

  ##########################
  # Public API
  ##########################

  @doc """
  Allows you to send a message via Send API

  ## Examples

      iex> body = %{
      ...>    "Messages": [
      ...>        %{
      ...>            "FromEmail": "pilot@mailjet.com",
      ...>            "FromName": "Your Mailjet Pilot",
      ...>            "Sender": true,
      ...>            "Recipients": [
      ...>                %{
      ...>                    "Email": "passenger@mailjet.com",
      ...>                    "Name": "Passenger 1",
      ...>                    "Vars": "array"
      ...>                }
      ...>            ],
      ...>            "To": "Passenger 1 <passenger@mailjet.com>",
      ...>            "Cc": "Passenger 2 <passenger2@mailjet.com>",
      ...>            "Bcc": "Passenger 3 <passenger3@mailjet.com>",
      ...>            "Subject": "Your email flight plan!",
      ...>            "Text-part": "Dear passenger, welcome to Mailjet! May the delivery force be with you!",
      ...>            "Html-part": "<h3>Dear passenger, welcome to Mailjet!</h3><br />May the delivery force be with you!",
      ...>            "Mj-TemplateID": 123456,
      ...>            "Mj-TemplateLanguage": false,
      ...>            "Mj-TemplateErrorReporting": "reports@example.com",
      ...>            "Mj-TemplateErrorDeliver": 0,
      ...>            "Attachments": [
      ...>                %{
      ...>                    "Filename": "test.txt",
      ...>                   "Content-type": "text/plain",
      ...>                    "Content": "VGhpcyBpcyB5b3VyIGF0dGFjaGVkIGZpbGUhISEK"
      ...>                }
      ...>            ],
      ...>            "Inline_attachments": [
      ...>                %{
      ...>                    "Filename": "logo.gif",
      ...>                    "Content-type": "image/gif",
      ...>                    "Content": "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"
      ...>                }
      ...>            ],
      ...>            "Mj-prio": 2,
      ...>            "Mj-campaign": "SendAPI_campaign",
      ...>            "Mj-deduplicatecampaign": 1,
      ...>            "Mj-trackopen": 0,
      ...>            "Mj-CustomID": "CustomValue",
      ...>            "Mj-EventPayload": "Eticket,1234,row,15,seat,B",
      ...>            "Mj-MonitoringCategory": "Category1",
      ...>            "Headers": "object",
      ...>            "Vars": "object"
      ...>        }
      ...>    ]
      ...>}
      iex> Mailjex.Send.send(body)
  """
  def send(body) do
    GenServer.call(__MODULE__, {:send, body})
  end


  ##########################
  # GenServer Callbacks
  ##########################

  def handle_call({:send, body}, _from, state) do
    %{:reply, Send.create(body), state}
  end

end
