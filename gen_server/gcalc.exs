defmodule GCalc do
  use GenServer

  def init(param) do
    IO.puts("Inicio del GenServer")
    IO.inspect(param)

    {:ok, %{conteo: 0}}
  end

  def handle_call({:add, n, m}, _from, %{conteo: conteo}) do
    IO.puts("handle_call(:add, #{n}, #{m})")
    resul = n + m
    {:reply, "#{resul} - conteo: #{conteo}", %{conteo: conteo + 1}}
  end
end
