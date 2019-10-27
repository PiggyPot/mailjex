defmodule Mailjex.Utils.Comms do
  @moduledoc false
  require Logger

  defp api_base, do: Application.fetch_env!(:mailjex, :api_base)
  defp public_api_key, do: Application.fetch_env!(:mailjex, :public_api_key)
  defp private_api_key, do: Application.fetch_env!(:mailjex, :private_api_key)

  def request(:get, path) do
    path
    |> api_url
    |> HTTPotion.get(headers())
  end

  def request(:get, path, options) do
    options = options ++ headers()
    path
    |> api_url
    |> HTTPotion.get(options)
  end

  def request(:put, path, body) do
    options = [body: Poison.encode!(body)]
    |> headers()

    path
    |> api_url
    |> HTTPotion.put(options)
  end

  def request(:delete, path, options) do
    options = options ++ headers()
    path
    |> api_url
    |> HTTPotion.delete(options)
  end

  def request(method, path, body, public_key \\ nil, private_key \\ nil)
  def request(:post, path, body, public_key, private_key) do
    hdrs = [body: Poison.encode!(body)]
    |> headers(public_key, private_key)

    development_mode = case Application.fetch_env(:mailjex, :development_mode) do
      {:ok, true} -> true
      _ -> false
    end

    if development_mode do
      Logger.info "Mailjex Development Mode Enabled"
      Logger.info "Mailjex Body: #{Poison.encode!(body)}"
      %HTTPotion.Response{body: "", headers: [], status_code: 200}
    else
      path
      |> api_url
      |> HTTPotion.post(hdrs)
    end
  end

  def request(:put, path, body, public_key, private_key) do
    hdrs = [body: Poison.encode!(body)]
    |> headers(public_key, private_key)

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
    api_base() <> url
  end

  defp headers, do: headers([])
  defp headers(body, public_key \\ nil, private_key \\ nil) do
    basic_auth = "#{public_key || public_api_key()}:#{private_key || private_api_key()}" |> Base.encode64
    [headers: ["Authorization": "Basic #{basic_auth}",
               "Accepts": "application/json",
               "Content-Type": "application/json"]] ++ body
  end
end
