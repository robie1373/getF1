ExUnit.start
defmodule GetTorrent.HelperFunctions do
  # IO.puts "this is helper"
end

defmodule GetTorrent.TestCache do
  import GetTorrent.CacheSearch, only: [setup: 0, cache_search: 0]

  import GetTorrent.PirateBayDecode, only: [
    decode_response: 1,
    to_torrent_record: 1
  ]

  import GetTorrent.PirateBayFilter, only: [filter_results: 1]

  import GetTorrent.PirateBaySort, only: [sort_results: 1]

  try do
    setup
    {:ok, id} = cache_search
    IO.puts("ETS id is: #{id}\n")
    @id id
  rescue
    _error -> _error
  end
  
  def record_id do
    @id
  end

  def c_result do
    c_record = hd(:ets.lookup(:cached_searches, record_id))
    c_record.result
  end

  def decoded_result do
    c_result
    |> decode_response
    |> to_torrent_record
  end

  def processed_result do
    decoded_result
    |> filter_results
    |> sort_results
  end
  
end
