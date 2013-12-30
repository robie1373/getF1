ExUnit.start
defmodule GetTorrent.HelperFunctions do

  import GetTorrent.PirateBaySearch, only: [
                                      query: 1,
                                      pirate_url: 1,
                                      fetch: 1,
                                      default_criteria: 0
                                    ]
  import GetTorrent.PirateBayDecode, only: [decode_response: 1, 
                                            to_torrent_record: 1
                                          ]

  @query_term "formula 1 2013"

  # def cached_result do
  #   File.read("#{__DIR__}/cached_search.txt")
  # end

 # def cache_search do
 #    default_criteria()
 #      |> pirate_url
 #      |> fetch
      # File.write(@path, result, :write)
  # end

# cached_search = cache_search

  def decoded_result do
    # cached_search
    default_criteria
    |> pirate_url
    |> fetch
    |> decode_response
    |> to_torrent_record
  end

  def make_list_of_uploaders([ [], accum]) do
    accum
  end
  
  def make_list_of_uploaders([ [head | tail], accum ]) do
    make_list_of_uploaders([tail, [head["uploader"] | accum]])
  end
  
  def make_list_of_uploaders(list) do
    make_list_of_uploaders([list, [] ])
  end


end