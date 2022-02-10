defmodule ClientDiscoveryWeb.ClientView do
  use ClientDiscoveryWeb, :view
  alias ClientDiscoveryWeb.ClientView

  def render("index.json", %{clients: clients}) do
    %{data: render_many(clients, ClientView, "client.json")}
  end

  def render("show.json", %{client: client}) do
    %{data: render_one(client, ClientView, "client.json")}
  end

  def render("client.json", %{client: client}) do
    %{
      id: client.id,
      internal_id: client.internal_id,
      internal_status: client.internal_status,
      import_category: client.import_category,
      import_ref: client.import_ref,
      owner: client.owner,
      retailer_import_url: client.retailer_import_url,
      retailer_name: client.retailer_name,
      ecommerce_tech: client.ecommerce_tech,
      network: client.network
    }
  end
end
