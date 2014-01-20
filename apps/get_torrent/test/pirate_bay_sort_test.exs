defmodule PirateBaySortTest do
  use ExUnit.Case

  # import GetTorrent.HelperFunctions
  import GetTorrent.PirateBayFilter, only: [
                                            filter_results: 1
  ]

  import GetTorrent.PirateBaySort, only: [
                                          sort_results: 1,
                                          change_rank: 2,
                                          ranks: 0
  ]

  import GetTorrent.PirateBayDecode, only: [
    decode_response: 1,
    to_torrent_record: 1
  ]
  # ft = Torrent_Result[id: 8894478, name: "Formula 1 2013 R12 Italian Grand Prix Race BBC", category: "TV shows", magnet: "magnet:?xt=urn:btih:457bc4f687026ea5fd821029ee2cf4d646c23bb9&dn=Formula+1+2013+R12+Italian+Grand+Prix+Race+BBC&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337", uploaded: "09-08 19:18", uploader: "footy", size: "1.59 GiB", seeders: 16, leechers: 8, trusted: true, rank: 0]

  ########### temp test #############
  # import GetTorrent.CacheSearch, only: [
  #   setup: 0,
  #   cache_search: 0,
  #   get_record: 1
  # ] 

  # setup_all do
  #   setup
  #   {:ok, id}     = cache_search
  #   {:ok, result} = get_record(id)

  #   {:ok, cached_result: result}
  # end

  # teardown_all do
  #   GetTorrent.CacheSearch.teardown(:cached_searches)
  #   :ok
  # end
  ###################################

  def check_sorting(list) do
    do_check_sorting([list, true])
  end

  defp do_check_sorting([[], accum]) do
    accum
  end

  @footy_rank  HashDict.get(ranks, "footy")
  defp do_check_sorting([[Torrent_Result[
    uploader: "footy", rank: rank] | tail], accum]) when rank == @footy_rank do
    do_check_sorting([tail, accum && true])
  end

  @tonyisaac_rank HashDict.get(ranks, "tonyisaac")
  defp do_check_sorting([[Torrent_Result[
    uploader: "tonyisaac", rank: rank] | tail], accum]) when rank == @tonyisaac_rank do
    do_check_sorting([tail, accum && true])
  end

  defp do_check_sorting([[Torrent_Result[
    uploader: _, rank: rank] | tail], accum]) when rank == 0 do
    do_check_sorting([tail, accum && true])
  end

  # @six_gb_rank HashDict.get(ranks, "6gb")
  # defp do_check_sorting([[Torrent_Result[
  #   bsize: bsize, rank: rank] | tail], accum]) when bsize > 6_000_000_000 && rank == @six_gb_rank do
  #   do_check_sorting([tail, accum && true])
  # end
  
  # @three_gb_rank HashDict.get(ranks, "3gb")
  # defp do_check_sorting([[Torrent_Result[
  #   bsize: bsize, rank: rank] | tail], accum]) when bsize > 3_000_000_000 && rank == @three_gb_rank do
  #   do_check_sorting([tail, accum && true])
  # end

  # @one_gb_rank HashDict.get(ranks, "1gb")
  # defp do_check_sorting([[Torrent_Result[
  #   bsize: bsize, rank: rank] | tail], accum]) when bsize > 1_000_000_000 && rank == @one_gb_rank do
  #   do_check_sorting([tail, accum && true])
  # end

  defp do_check_sorting([[ _ | tail], accum]) do
    do_check_sorting([tail, accum && false])
  end

  test "rank_uploaders", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record

    assert decoded_result 
    |> filter_results 
    |> sort_results
    |> check_sorting, "rank up failed to match expected. it is possible that the values in @ranks has changed but the tests were not updated."
  end

  test "rank up a record", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record

    record = List.last(decoded_result)
    initial_rank = record.rank
    new_record = change_rank(record, 2)
    assert new_record.rank == initial_rank + 2
  end

  test "rank size", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record
    
    assert decoded_result
    |> filter_results
    |> sort_results
    |> check_sorting, "rank up failed to match expected. it is possible that the values in @ranks has changed but the tests were not updated."
  end
end