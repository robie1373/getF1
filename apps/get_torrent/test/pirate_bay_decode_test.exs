defmodule PirateBayDecodeTest do
  use ExUnit.Case
  # import GetTorrent.PirateBayDecode, only: [
                                      # decode_response: 1,
                                      # to_torrent_record: 1
                                      # ]

  import GetTorrent.HelperFunctions

  test "decode the body" do
    record = List.last(decoded_result)
    assert record.id 
  end

  test "convert to records" do
    assert decoded_result 
    |> Enum.all?( fn(x) -> is_record(x, Torrent_Result) end)
  end
end