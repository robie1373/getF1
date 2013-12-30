defmodule PirateBayFilterTest do
  use ExUnit.Case
  import GetTorrent.PirateBayFilter, only: [
                                      filter_results: 1
                                      ]

  import GetTorrent.HelperFunctions

  test "filter responses to videos only" do
    filtered_results = decoded_result |> filter_results

    assert length(filtered_results) > 0
    assert filtered_results 
    |> Enum.all?(fn(x) -> 
      x.category == "TV shows" end)
      # List.keyfind(x, "category", 0) == {"category", "TV shows"} end)
  end


end