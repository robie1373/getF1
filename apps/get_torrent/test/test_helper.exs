ExUnit.start
defmodule GetTorrent.HelperFunctions do
  # IO.puts "this is helper"
end

defmodule GetTorrent.TestCache do
  import GetTorrent.CacheSearch, only: [setup: 0, cache_search: 0]
  try do
    setup
    {:ok, id} = cache_search
    IO.puts("ETS id is: #{id}\n")
    @id id
    # IO.puts("@id is: #{@id}\n")
  rescue
    _error -> _error
  end
  
  def record_id do
    @id
  end

end
