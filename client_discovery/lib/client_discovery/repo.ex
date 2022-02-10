defmodule ClientDiscovery.Repo do
  use Ecto.Repo,
    otp_app: :client_discovery,
    adapter: Ecto.Adapters.Postgres
end
