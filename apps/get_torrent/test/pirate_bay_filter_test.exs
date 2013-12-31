defmodule PirateBayFilterTest do
  use ExUnit.Case
  import GetTorrent.PirateBayFilter, only: [
                                      filter_results: 1
                                      ]

  import GetTorrent.PirateBayDecode, only: [
    to_torrent_record: 1,
    decode_response: 1
  ]
  # import GetTorrent.HelperFunctions

  ########### temp test #############
  import GetTorrent.CacheSearch, only: [
    setup: 0,
    cache_search: 0,
    get_record: 1
  ] 

  setup_all do
    setup
    {:ok, id}     = cache_search
    {:ok, result} = get_record(id)

    {:ok, cached_result: result}
  end

  teardown_all do
    GetTorrent.CacheSearch.teardown(:cached_searches)
    :ok
  end
  ###################################

  test "filter responses to videos only", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record
    |> filter_results

    filtered_results = decoded_result |> filter_results

    assert length(filtered_results) > 0
    assert filtered_results 
    |> Enum.all?(fn(x) -> 
      x.category == "TV shows" end)
      # List.keyfind(x, "category", 0) == {"category", "TV shows"} end)
  end


end