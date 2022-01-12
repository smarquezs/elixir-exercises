defmodule Hello.ImportMovies do
  def import() do
    api_key = System.get_env("MOVIE_API_KEY")

    api_url =
      "https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}&language=es-ES&page=1"

    response = HTTPoison.get!(api_url)

    response.body
    |> Jason.decode!()
    |> IO.inspect()
  end
end
