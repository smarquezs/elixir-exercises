defmodule ClientDiscovery.Clients.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :ecommerce_tech, :string
    field :import_category, :string
    field :import_ref, :string
    field :internal_id, :string
    field :internal_status, :string
    field :owner, :string
    field :retailer_import_url, :string
    field :retailer_name, :string
    field :network, :string

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:internal_id, :internal_status, :import_category, :import_ref, :owner, :retailer_import_url, :retailer_name, :ecommerce_tech])
    |> validate_required([:internal_id, :retailer_import_url, :retailer_name])
  end
end
