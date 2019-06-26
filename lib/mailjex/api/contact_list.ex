defmodule Mailjex.Api.ContactList do
  @moduledoc false
  import Mailjex.Utils.Comms

  def manage_contact(id, body) do
    request(:post, "/REST/contactslist/#{id}/managecontact", body)
    |> decode_json
  end
end
