defmodule Mailjex.Behaviour.Delivery do
  @moduledoc false

  @callback send(map()) :: tuple()
end