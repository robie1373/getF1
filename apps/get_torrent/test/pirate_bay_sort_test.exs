defmodule PirateBaySortTest do
  use ExUnit.Case

  import GetTorrent.HelperFunctions
  import GetTorrent.PirateBayFilter, only: [
                                            filter_results: 1
  ]

  import GetTorrent.PirateBaySort, only: [
                                          sort_results: 1,
                                          change_rank: 2
  ]

  # ft = Torrent_Result[id: 8894478, name: "Formula 1 2013 R12 Italian Grand Prix Race BBC", category: "TV shows", magnet: "magnet:?xt=urn:btih:457bc4f687026ea5fd821029ee2cf4d646c23bb9&dn=Formula+1+2013+R12+Italian+Grand+Prix+Race+BBC&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337", uploaded: "09-08 19:18", uploader: "footy", size: "1.59 GiB", seeders: 16, leechers: 8, trusted: true, rank: 0]

  def check_sorting(list) do
    do_check_sorting([list, true])
  end

  defp do_check_sorting([[], accum]) do
    accum
  end

  defp do_check_sorting([[Torrent_Result[
    uploader: "footy", rank: rank] | tail], accum]) when rank == 2 do
    do_check_sorting([tail, accum && true])
  end

  defp do_check_sorting([[Torrent_Result[uploader: "tonyisaac", rank: rank] | tail], accum]) when rank == 3 do
    do_check_sorting([tail, accum && true])
  end

  defp do_check_sorting([[Torrent_Result[uploader: _, rank: rank] | tail], accum]) when rank == 0 do
    do_check_sorting([tail, accum && true])
  end

  defp do_check_sorting([[ _ | tail], accum]) do
    do_check_sorting([tail, accum && false])
  end

  test "tonyisaac and footy get ranked up" do
    assert decoded_result 
    |> filter_results 
    |> sort_results
    |> check_sorting
  end

  test "rank up a record" do
    record = List.last(decoded_result)
    initial_rank = record.rank
    new_record = change_rank(record, 2)
    assert new_record.rank == initial_rank + 2
  end

end