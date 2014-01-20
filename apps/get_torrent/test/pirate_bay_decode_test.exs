defmodule PirateBayDecodeTest do
  use ExUnit.Case, async: true
  # use ExUnit.Case
  import GetTorrent.PirateBayDecode, only: [
                                      decode_response: 1,
                                      to_torrent_record: 1
                                      ]

  import GetTorrent.TestCache

  c_record = hd(:ets.lookup(:cached_searches, record_id))
  @c_result c_record.result

  test "decode the body" do
    decoded_result = @c_result
    |> decode_response
    |> to_torrent_record

    assert List.last(decoded_result).id 
  end

  def test_byte_size([head=Torrent_Result[]|_tail]) do
    if head.byte_size > 0 do
      true
    else
      false
    end
  end

  def test_byte_size(_input) do
    # IO.puts "\nNot very serious Failure: #{inspect(Enum.first(input))} is not a Torrent_Result"
    false
  end


  def test_byte_size_type([head=Torrent_Result[]|_tail]) do
    if is_float(head.byte_size) do
      true
    else
      false
    end
  end

  def test_byte_size_type(_input) do
    # IO.puts "\nNot very serious Failure: #{inspect(Enum.first(input))} is not a Torrent_Result"
    false
  end

  test "byte_size gets updated, > 0" do
    decoded_result = @c_result
    |> decode_response
    |> to_torrent_record

    assert decoded_result 
    |> test_byte_size, "byte_size was not > 0"
  end

  test "byte_size gets updated, is_float" do
    decoded_result = @c_result
    |> decode_response
    |> to_torrent_record

    assert decoded_result
    |> test_byte_size_type, "byte_size is not an float"
  end

  test "convert to records" do
    assert @c_result
    |> decode_response
    |> to_torrent_record
    |> Enum.all?( fn(x) -> is_record(x, Torrent_Result) end)
  end
end