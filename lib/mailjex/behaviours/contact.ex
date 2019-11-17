defmodule Mailjex.Behaviour.Contact do
  @moduledoc false

  @callback create(map()) :: tuple()
  @callback view(integer()) :: tuple()
  @callback list() :: tuple()
  @callback update(integer(), map()) :: tuple()
  @callback manage_contacts_lists(integer(), map()) :: tuple()
  @callback get_contacts_lists(integer()) :: tuple()
end
