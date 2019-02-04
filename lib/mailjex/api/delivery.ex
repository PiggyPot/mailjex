defmodule Mailjex.Api.Delivery do
  @moduledoc false
  import Mailjex.Utils.Comms

  def send(body, public_key \\ nil, private_key \\ nil) do
    request(:post, "/send", body, public_key, private_key)
    |> decode_json
  end
end
