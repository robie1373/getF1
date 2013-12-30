defmodule CacheSearch do
  import GetTorrent.PirateBaySearch, only: [pirate_url: 1, 
                                            default_criteria: 0,
                                            fetch: 1]

  @path  "cached_search.txt"

  def cache_search() do
    result = default_criteria()
      |> pirate_url
      |> fetch
      File.write(@path, result, :write)
  end
end

# CacheSearch.cache_search