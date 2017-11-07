defmodule Mailjex.Utils.Comms do
  @moduledoc false
  @api_base Application.fetch_env!(:mailjex, :api_base)
  @public_api_key Application.fetch_env!(:mailjex, :public_api_key)
  @private_api_key Application.fetch_env!(:mailjex, :private_api_key)
  @development_mode Application.fetch_env!(:mailjex, :development_mode)

  def request(:get, path) do
    path
    |> api_url
    |> HTTPotion.get(headers())
  end

  def request(:post, path, body) do
    hdrs = [body: Poison.encode!(body)]
    |> headers

    if @development_mode do
      IO.inspect(hdrs)
      %HTTPotion.Response{body: hdrs, headers: [], status_code: 200}
    else
      path
      |> api_url
      |> HTTPotion.post(hdrs)
    end
  end

  def request(:put, path, body) do
    hdrs = [body: Poison.encode!(body)]
    |> headers

    path
    |> api_url
    |> HTTPotion.put(hdrs)
  end

  def decode_json(resp_map) do
    body = case resp_map.body do
      "" -> "No Body"
      body -> Poison.decode!(body)
    end

    case resp_map.status_code do
      x when x in [200, 201, 204] -> {:ok, body}
      _ -> {:error, body}
    end
  end

  defp api_url(url) do
    @api_base <> url
  end

  defp headers, do: headers([])
  defp headers(body) do
    basic_auth = "#{@public_api_key}:#{@private_api_key}" |> Base.encode64
    [headers: ["Authorization": "Basic #{basic_auth}",
               "Accepts": "application/json",
               "Content-Type": "application/json"]] ++ body
  end
end
