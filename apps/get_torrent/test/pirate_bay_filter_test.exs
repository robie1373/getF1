defmodule PirateBayFilterTest do
  use ExUnit.Case
  import GetTorrent.PirateBayFilter, only: [
                                      filter_results: 1
                                      ]

  import GetTorrent.PirateBayDecode, only: [
    to_torrent_record: 1,
    decode_response: 1
  ]
  import GetTorrent.TestCache

  test "filter responses to videos only" do
    c_record = hd(:ets.lookup(:cached_searches, record_id))
    c_result = c_record.result

    decoded_result = c_result
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