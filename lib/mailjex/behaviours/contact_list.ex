defmodule Mailjex.Behaviour.ContactList do
  @moduledoc false

  @callback manage_contact(integer(), map()) :: tuple()
end
