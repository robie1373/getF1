defmodule GetTorrent.CacheSearchTest do
  use ExUnit.Case

  import GetTorrent.CacheSearch, only: [setup: 0,
    verify: 1 ]

  test "creates an ets table" do
    setup
    name = :cached_searches
    assert :ets.info(name)[:name] == name
  end
end