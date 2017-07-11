defmodule Mailjex.Api.Delivery do
  @moduledoc false
  import Mailjex.Utils.Comms
  
  def send(body) do
    request(:post, "/send", body)
    |> decode_json
  end
end
