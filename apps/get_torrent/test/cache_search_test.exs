defmodule GetTorrent.CacheSearchTest do
  use ExUnit.Case, async: false

###### READ THIS #######
## This/these tests are for testing the creation of the cached
## version of the search. This prevents some of the failures
## caused by getting rate limited by the apify service.
## These tests are likely to be a pain in the butt because
## much side effects and serious anger. Feel free to run these
## separately and in isolation if you think the caching is 
## borked. Otherwise let this slide.
#######################


  # import GetTorrent.CacheSearch, only: [setup: 0]

  # setup do
  #   :ets.delete(:cached_searches)
  # end

  # test "creates an ets table" do
  #   name = :cached_searches
  #   # if :ets.info(name)[:name] == name do
  #   #   GetTorrent.CacheSearch.teardown(name)
  #   # end
  #   setup
  #   assert :ets.info(name)[:name] == name
  # end
end