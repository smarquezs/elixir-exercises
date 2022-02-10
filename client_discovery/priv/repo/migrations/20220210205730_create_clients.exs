defmodule ClientDiscovery.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :internal_id, :string
      add :internal_status, :string
      add :import_category, :string
      add :import_ref, :string
      add :owner, :string
      add :retailer_import_url, :string
      add :retailer_name, :string
      add :ecommerce_tech, :string
      add :network, :string

      timestamps()
    end
  end
end
