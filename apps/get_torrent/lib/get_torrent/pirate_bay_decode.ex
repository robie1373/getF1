defmodule GetTorrent.PirateBayDecode do

  def decode_response({:ok, body}), do: Jsonex.decode(body)
  def decode_response({:error, msg}) do
    error = Jsonex.decode(msg)["message"]
    IO.puts "Error fetching from Github: #{error}"
    System.halt(2)
  end

  def set_byte_size(record=Torrent_Result[]) do
    [num, exp] = String.split(record.size)
    set_byte_size(num, exp, record)
  end

  def set_byte_size(num, exp, record) do
    exponents = ["GiB": 1_000_000_000, "MiB": 1_000_000, "KiB": 1_000_000]
    record.update(byte_size: binary_to_float(num) * exponents[binary_to_atom(exp)])
  end
  
  def enhance_record(list) do
    list
    |> Enum.map(fn(x) -> x ++ [rank: 0, byte_size: 0] end)
  end

  def to_torrent_record(list) do
    list 
    |> enhance_record
    |> Enum.map( fn(x) -> Torrent_Result.new(x) end)
    |> Enum.map( fn(x) -> set_byte_size(x) end)
  end

end