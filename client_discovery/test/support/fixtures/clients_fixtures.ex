defmodule ClientDiscovery.ClientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ClientDiscovery.Clients` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        ecommerce_tech: "some ecommerce_tech",
        import_category: "some import_category",
        import_ref: "some import_ref",
        internal_id: "some internal_id",
        internal_status: "some internal_status",
        owner: "some owner",
        retailer_import_url: "some retailer_import_url",
        retailer_name: "some retailer_name"
      })
      |> ClientDiscovery.Clients.create_client()

    client
  end
end
