defmodule GetTorrent.CacheSearch do

  import GetTorrent.PirateBaySearch, only: [pirate_url: 1, 
                                            default_criteria: 0,
                                            fetch: 1]

  def setup do
    :ets.new(
    :cached_searches, [:named_table, {:keypos, 
      CacheSearchRecord.__record__(:index, :search_id) + 1} ])
  end

  def verify(table_name) do
    IO.puts(inspect :ets.info(table_name) )
  end

  def teardown(table_name) do
    :ets.delete(table_name)
  end

  defp create_id do
    elem(:os.timestamp, 1)
  end

  def run_online_search do
   default_criteria()
    |> pirate_url
    |> fetch
  end

  def cache_search do
    do_cache_search(run_online_search)
  end

  defp do_cache_search(result = {:ok, _ }) do
    new_id = create_id
    :ets.insert(
      :cached_searches, 
      CacheSearchRecord.new([search_id: new_id, result: result])
      )
    {:ok, new_id}
  end

  defp do_cache_search({:error, err}) do
    backoff = 2_000
    IO.puts(inspect err)
    IO.puts "retrying in #{backoff / 1_000} seconds"
    :timer.sleep(backoff)
    cache_search
  end

  def get_record(id) do
    # IO.puts("in CacheSearch the record looks like:\n#{inspect(hd(:ets.lookup(:cached_searches, id)))}")
    {:ok, hd(:ets.lookup(:cached_searches, id))}
  end

end


# GetTorrent.CacheSearch.setup
# {:ok, id} = GetTorrent.CacheSearch.cache_search
# {:ok, result} = GetTorrent.CacheSearch.get_record(id)
# IO.puts("result is literally:\n#{inspect(result)}")
# # CacheSearch.verify(:cached_searches)
# # IO.puts(inspect CacheSearch.get_record(id))
# GetTorrent.CacheSearch.teardown(:cached_searches)
