defmodule GetTorrent.PirateBaySearch do
  alias HTTPotion.Response
  
  import GetTorrent.PirateBayDecode,  only: [decode_response: 1, to_torrent_record: 1]
  import GetTorrent.PirateBayFilter,  only: [filter_results: 1]
  import GetTorrent.PirateBaySort,    only: [sort_results: 1]
  import GetTorrent.DisplayCli,       only: [print_cli: 1]

  @base_url   "http://apify.ifc0nfig.com"
  # @categories [ video: 200, audio: 100, applications: 300, games: 400, other: 600 ]
  # @ordering   [ default: 99 ]
  @api_key "0ba7e46015584148b0755fb0b4af9483"
  # @page       0
  # @category   :video

  def query(query_term) do
    "search?id=" <> URI.encode(query_term) <> "&key=#{@api_key}"
  end
  
  @user_agent [ "User-agent": "Bonzer foo@bar.baz" ]

  def default_criteria do
    [query_term: "formula 1 2013", page: 0, ordering: 99, category: 200]
  end

  def main(_argv) do
    default_criteria()
      |> pirate_url
      |> fetch
      |> decode_response
      |> to_torrent_record
      |> filter_results
      |> sort_results
      |> print_cli
  end

  def pirate_url( search_criteria ) do
    Enum.join([
        @base_url, 
        "tpb",
        query(search_criteria[:query_term])
      ], "/")
  end
  
  def fetch(url) do
    case HTTPotion.get(url, @user_agent) do
      Response[body: body, status_code: status, headers: _headers ]
      when status in 200..299 ->
        { :ok, body }
      Response[body: body, status_code: _status, headers: _headers ] ->
        { :error, body }
    end
  end


end