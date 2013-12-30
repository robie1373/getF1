defmodule PirateBaySearchTest do
  use ExUnit.Case

  import GetTorrent.PirateBaySearch, only: [
                                      query: 1,
                                      default_criteria: 0,
                                      pirate_url: 1,
                                      fetch: 1
                                    ]
  import GetTorrent.PirateBayDecode, only: [decode_response: 1]                                    

  @api_key "0ba7e46015584148b0755fb0b4af9483"
  @query_term "formula 1 2013"
  @query query("formula 1 2013")
  @test_url "http://apify.ifc0nfig.com/tpb/#{@query}"

  test "default_criteria" do
    assert default_criteria == [query_term: "formula 1 2013", 
    page: 0, ordering: 99, category: 200]
  end

  test "pirate_url_creation" do
    assert pirate_url([ query_term: @query_term ]) == @test_url
  end

  def test_result({:ok, _body}), do: true
  def test_result(_), do: false 
  

  test "fetch returns :ok" do
    assert(test_result(fetch(@test_url)))
    
  end

 
  def decoded_result do
    pirate_url([ query_term: @query_term ])
    |> fetch
    |> decode_response
  end


  
@doc """
create url -> submit search -> parse response -> filter response ->
  sort response -> display response -> 
  user input selected downloads -> download or open .torrent
"""
end