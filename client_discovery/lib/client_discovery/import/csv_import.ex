defmodule ClientDiscovery.Import.CSVImport do
  alias NimbleCSV.RFC4180, as: CSV
  alias ClientDiscovery.{Clients, Clients.Client, Repo}

  def perform do
    file = "/tmp/data.csv"
    column_names = get_column_names(file)

    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: true)
    |> Enum.map(fn row ->
      row
      |> Enum.with_index()
      |> Map.new(fn {val, num} -> {column_names[num], val} end)
      |> skip_or_create()
    end)
  end

  defp get_column_names(file) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)
  end

  defp skip_or_create(row) do
    case Repo.get_by(Client, internal_id: row["_internal_id"]) do
      nil ->
        Clients.create_client(%{
          internal_id: row["_internal_id"],
          internal_status: row["_internal_import_status"],
          retailer_name: row["Retailer name"],
          retailer_import_url: row["Retailer Import URL"],
          import_ref: row["Import ref"],
          import_category: row["Import Category"],
          owner: row["Owner"],
          ecommerce_tech: row["ecommerce tech"],
          network: row["network"]
        })

      client ->
        {:ok, client}
    end
  end
end
