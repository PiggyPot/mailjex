defmodule Mailjex.Api.Message do
  @moduledoc false
  import Mailjex.Utils.Comms

  def list(params \\ %{}) do
    url_params = params |> URI.encode_query
    IO.inspect url_params

    request(:get, "/REST/message?#{url_params}")
    |> decode_json
  end

  def history(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/REST/messagehistory?#{url_params}")
    |> decode_json
  end

  def information(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/REST/messageinformation?#{url_params}")
    |> decode_json
  end

  def sent_statistics(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/REST/messagesentstatistics?#{url_params}")
    |> decode_json
  end

  def state(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/REST/messagestate?#{url_params}")
    |> decode_json
  end

  def statistics(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/REST/messagestatistics?#{url_params}")
    |> decode_json
  end
end
