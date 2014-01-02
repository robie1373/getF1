defmodule PirateBayDecodeTest do
  use ExUnit.Case
  import GetTorrent.PirateBayDecode, only: [
                                      decode_response: 1,
                                      to_torrent_record: 1
                                      ]

  # import GetTorrent.HelperFunctions

############## temp test ################
import GetTorrent.CacheSearch, only: [
  setup: 0,
  cache_search: 0,
  get_record: 1
] 

setup_all do
  try do
    setup
  rescue
    _error -> _error
  end

  {:ok, id}     = cache_search
  {:ok, result} = get_record(id)

  {:ok, cached_result: result}
end

# teardown_all do
#   GetTorrent.CacheSearch.teardown(:cached_searches)
#   :ok
# end
#########################################
 
  test "decode the body", meta do
    # record = List.last(decoded_result)
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record

    assert List.last(decoded_result).id 
  end

  def test_byte_size([head|_tail]) do
    IO.puts("true: #{inspect(head)}")
    # if head.byte_size > 0 do
    if head.byte_size > 0 do
      true
    else
      IO.puts("false: #{inspect(head)}")
      false
    end
  end

  def test_byte_size_type([head|_tail]) do
    if is_integer(head) do
      true
    else
      false
    end
  end

  test "byte_size gets updated, > 0", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record

    assert decoded_result 
    |> test_byte_size, "byte_size was not > 0"
  end

  test "byte_size gets updated, is_integer", meta do
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]

    decoded_result = {:ok, result}
    |> decode_response
    |> to_torrent_record

    assert decoded_result
    |> test_byte_size_type, "byte_size is not an integer"
  end

###############
# CacheSearchRecord[search_id: 435942, result: {:ok, "[{\"id\":8997672,\"name\""
###################
  test "convert to records", meta do
    # assert decoded_result 
    ## try using the record matching pattern stuff from the book
    ## to match the CacheSearchRecord above. You just need to 
    ## extract the CacheSearchRecord[:result]
    CacheSearchRecord[result: {:ok, result}] = meta[:cached_result]
    # IO.puts "the meta result looks like :\n#{(is_binary result)}"
    # assert meta[:cached_result]
    assert {:ok, result}
    |> decode_response
    |> to_torrent_record
    |> Enum.all?( fn(x) -> is_record(x, Torrent_Result) end)
  end
end