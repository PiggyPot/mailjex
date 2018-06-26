defmodule Mailjex.Api.Contact do
  @moduledoc false
  import Mailjex.Utils.Comms

  def create(body) do
    request(:post, "/REST/contact", body)
    |> decode_json
  end

  def view(id) do
    request(:get, "/REST/contact/#{id}")
    |> decode_json
  end

  def list do
    request(:get, "/REST/contact")
    |> decode_json
  end

  def update(id, body) do
    request(:put, "/REST/contact/#{id}", body)
    |> decode_json
  end

  def manage_contacts_lists(id, body) do
    request(:post, "/REST/contact/#{id}/managecontactslists", body)
    |> decode_json
  end
end
