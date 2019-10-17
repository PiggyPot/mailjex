defmodule Mailjex.Api.ContactList do
  @moduledoc false
  import Mailjex.Utils.Comms

  def manage_contact(id, body) do
    request(:post, "/REST/contactslist/#{id}/managecontact", body)
    |> decode_json
  end

  def manage_contact_in_list(list_id, body) do
    request(:post, "/REST/contactslist/#{list_id}/managemanycontacts", body)
    |> decode_json
  end

  def create_contact_list(name, is_deleted = false) do
    request(:post, "/REST/contactslist", %{
      Name: name,
      IsDeleted: is_deleted
    })
    |> decode_json
  end

  def get_all_contact_lists(options \\ []) do
    request(:get, "/REST/contactslist", options)
    |> decode_json
  end

  def get_contact_list(list_id, options \\ []) do
    request(:get, "/REST/contactslist/#{list_id}", options)
    |> decode_json
  end

  def update_contact_list(list_id, body) do
    request(:put, "/REST/contactslist/#{list_id}", body)
    |> decode_json
  end

  def delete_contact_list(list_id, options \\ []) do
    request(:delete, "/REST/contactslist/#{list_id}", options)
    |> decode_json
  end

end
