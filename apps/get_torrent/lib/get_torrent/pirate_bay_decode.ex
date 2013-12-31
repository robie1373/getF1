defmodule GetTorrent.PirateBayDecode do

  def decode_response({:ok, body}), do: Jsonex.decode(body)
  def decode_response({:error, msg}) do
    error = Jsonex.decode(msg)["message"]
    IO.puts "Error fetching from Github: #{error}"
    System.halt(2)
  end

  def set_byte_size(record) do
    exponents = ["GiB": 1_000_000_000, "MiB": 1_000_000, "KiB": 1_000_000]
    [num, exp] = String.split(record.size)
    binary_to_float(num) * exponents[binary_to_atom(exp)]
  end
  
  def to_torrent_record(list) do
    IO.puts "x is a list #{is_list List.last(list)}"
    Enum.map(list, fn(x) -> Torrent_Result.new(x) end)
    # Enum.map(list, fn(x) -> x.update_byte_size(set_byte_size(x)) end)
    
    # [binary_to_float(num) * exponents[binary_to_atom(exp)]]
    # Enum.map(list, fn(x) -> x.bsize end)
  end
  
end