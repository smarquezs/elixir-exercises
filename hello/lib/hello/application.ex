defmodule Hello.Application do
  use Application

  @impl true
  def start(_type, _args) do
    Hello.ImportMovies.import()

    opts = [strategy: :one_for_one, name: Hello.Supervisor]
    Supervisor.start_link([], opts)
  end
end
