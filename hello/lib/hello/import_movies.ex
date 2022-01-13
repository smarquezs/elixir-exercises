defmodule Hello.ImportMovies do
  def import() do
    api_key = System.get_env("MOVIE_API_KEY")

    movies =
      Enum.reduce(1..150, [], fn page, list ->
        api_url =
          "https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}&language=es-ES&page=#{
            page
          }"

        IO.puts("Fetching page #{page}")
        response = HTTPoison.get!(api_url)
        response = response.body |> Jason.decode!()

        results =
          response["results"]
          |> Enum.map(fn movie ->
            %{
              title: movie["title"],
              overview: movie["overview"],
              id: movie["id"],
              vote_average: movie["vote_average"],
              vote_count: movie["vote_count"],
              page: response["page"],
              release_date: movie["release_date"]
            }
          end)

        list ++ results
      end)

    movies = Jason.encode!(movies)
    File.write!("/tmp/movies.json", movies, [:write])
  end
end
