defmodule Mailjex.Api.Template do
  @moduledoc false
  import Mailjex.Utils.Comms

  def list(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/REST/template?#{url_params}")
    |> decode_json
  end
end
