defmodule AirtableApi.Article do
  import AirtableApi.Request

  def retrieve(id) do
    url = "#{base_url()}/#{id}"
    perform_request(url, :get, headers())
  end

  def list() do
    perform_request(base_url(), :get, headers())
  end

  def update(id, fields) do
    body =
      %{
        records: [
          %{
            id: id,
            fields: fields
          }
        ]
      }
      |> Jason.encode!()

    perform_request(base_url(), :patch, headers(), body)
  end

  def create(fields) do
    body =
      %{
        records: [
          %{
            fields: fields
          }
        ]
      }
      |> Jason.encode!()

    perform_request(base_url(), :post, headers(), body)
  end

  def delete(id) do
    url = "#{base_url()}/#{id}"

    perform_request(url, :delete, headers())
  end

  defp headers do
    [Authorization: "Bearer #{api_key()}", "Content-Type": "application/json"]
  end

  defp base_url, do: "https://api.airtable.com/v0/#{base_id()}/#{table()}"
  defp base_id, do: System.get_env("AIRTABLE_BASE_ID")
  defp api_key, do: System.get_env("AIRTABLE_API_KEY")
  defp table, do: "Article"
end
