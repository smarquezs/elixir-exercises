defmodule AirtableApi.Request do
  def perform_request(url, method, headers, body \\ "") do
    request = %HTTPoison.Request{
      method: method,
      url: url,
      headers: headers,
      body: body
    }

    case HTTPoison.request(request) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> Jason.decode!()}

      {:ok, %HTTPoison.Response{} = response} ->
        {:error, response}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
