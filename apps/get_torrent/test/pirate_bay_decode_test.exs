defmodule PirateBayDecodeTest do
  # use ExUnit.Case, async: true
  use ExUnit.Case
  import GetTorrent.PirateBayDecode, only: [
                                      decode_response: 1,
                                      to_torrent_record: 1
                                      ]

  # import GetTorrent.HelperFunctions

############## temp test ################
# import GetTorrent.CacheSearch, only: [
#   setup: 0,
#   cache_search: 0,
#   get_record: 1
# ] 

# setup_all do
#   try do
#     setup
#   rescue
#     _error -> _error
#   end

#   {:ok, id}     = cache_search
#   {:ok, result} = get_record(id)

#   {:ok, cached_result: result}
# end

# teardown_all do
#   GetTorrent.CacheSearch.teardown(:cached_searches)
#   :ok
# end
#########################################
 
  test "decode the body", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
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

  test "byte_size gets updated, > 0", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record

    assert decoded_result 
    |> test_byte_size, "byte_size was not > 0"
  end

  test "byte_size gets updated, is_float", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record

    assert decoded_result
    |> test_byte_size_type, "byte_size is not an float"
  end

  test "convert to records", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]
    assert {:ok, result}
    |> decode_response
    |> to_torrent_record
    |> Enum.all?( fn(x) -> is_record(x, Torrent_Result) end)
  end
end