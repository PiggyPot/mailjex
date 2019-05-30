defmodule Mailjex.Behaviour.Send do
  @moduledoc false

  @callback send(map()) :: tuple()
end
