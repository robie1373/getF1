ExUnit.start
defmodule GetTorrent.HelperFunctions do
  use ExUnit.Case, async: true

  # import GetTorrent.CacheSearch, only: [
  #   setup: 0,
  #   cache_search: 0,
  #   get_record: 1,
  #   teardown: 1
  # ]                                          

  # import GetTorrent.PirateBaySearch, only: [
  #                                     query: 1,
  #                                     pirate_url: 1,
  #                                     fetch: 1,
  #                                     default_criteria: 0
  #                                   ]
  # import GetTorrent.PirateBayDecode, only: [decode_response: 1, 
  #                                           to_torrent_record: 1
  #                                         ]

  @query_term "formula 1 2013"

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

  # def decoded_result do
  #   meta[:cached_result]
  #   |> decode_response
  #   |> to_torrent_record
  # end

  # def make_list_of_uploaders([ [], accum]) do
  #   accum
  # end
  
  # def make_list_of_uploaders([ [head | tail], accum ]) do
  #   make_list_of_uploaders([tail, [head["uploader"] | accum]])
  # end
  
  # def make_list_of_uploaders(list) do
  #   make_list_of_uploaders([list, [] ])
  # end


end