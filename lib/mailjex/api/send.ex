defmodule Mailjex.Api.Send do
  @moduledoc false
  import Mailjex.Utils.Comms

  def send(body) do
    request(:post, "/REST/send", body)
    |> decode_json
  end

end
