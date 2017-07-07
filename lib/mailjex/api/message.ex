defmodule Mailjex.Api.Message do
  import Mailjex.Utils.Comms

  def list(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/message?#{url_params}")
    |> decode_json
  end

  def history(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/messagehistory?#{url_params}")
    |> decode_json
  end

  def information(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/messageinformation?#{url_params}")
    |> decode_json
  end

  def sent_statistics(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/messagesentstatistics?#{url_params}")
    |> decode_json
  end

  def state(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/messagestate?#{url_params}")
    |> decode_json
  end

  def statistics(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/messagestatistics?#{url_params}")
    |> decode_json
  end
end
