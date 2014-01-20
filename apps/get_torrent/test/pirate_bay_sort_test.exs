defmodule PirateBaySortTest do
  use ExUnit.Case, async: true

  import GetTorrent.TestCache
  import GetTorrent.PirateBayFilter, only: [
                                            filter_results: 1
  ]

  import GetTorrent.PirateBaySort, only: [
                                          sort_results: 1,
                                          change_rank: 2,
                                          ranks: 0
  ]

  # import GetTorrent.PirateBayDecode, only: [
  #   decode_response: 1,
  #   to_torrent_record: 1
  # ]
 
  def check_sorting(list) do
    do_check_sorting([list, true])
  end

  defp do_check_sorting([ [], accum]) do
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

  test "rank_uploaders" do
    assert processed_result
    |> check_sorting, "rank up failed to match expected. it is possible that the values in @ranks has changed but the tests were not updated."
  end

  test "rank up a record" do
    record = List.last(decoded_result)
    initial_rank = record.rank
    new_record = change_rank(record, 2)
    assert new_record.rank == initial_rank + 2
  end

  test "rank size" do
    assert processed_result
    |> check_sorting, "rank up failed to match expected. it is possible that the values in @ranks has changed but the tests were not updated."
  end
end