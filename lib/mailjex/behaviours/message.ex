defmodule Mailjex.Behaviour.Message do
  @moduledoc false

  @callback list(map()) :: tuple()
  @callback history(map()) :: tuple()
  @callback information(map()) :: tuple()
  @callback sent_statistics(map()) :: tuple()
  @callback state(map()) :: tuple()
  @callback statistics(map()) :: tuple()
end