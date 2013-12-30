defmodule GetTorrent.PirateBayDecode do

  def decode_response({:ok, body}), do: Jsonex.decode(body)
  def decode_response({:error, msg}) do
    error = Jsonex.decode(msg)["message"]
    IO.puts "Error fetching from Github: #{error}"
    System.halt(2)
  end

  
  def to_torrent_record(list) do
    Enum.map(list, fn(x) -> Torrent_Result.new(x) end)
  end
  
end