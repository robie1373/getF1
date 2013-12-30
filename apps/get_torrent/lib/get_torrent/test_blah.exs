
defrecord Torrent_Result, id: 0, name: "", category: "",
  magnet: "", uploaded: "", uploader: "", size: 0, seeders: 0,
  leechers: 0, trusted: false, rank: 0

defmodule TestBlah do

  


  def size_to_float(record) do
    [num, exp] = String.split(record.size)
    exponents = ["GiB": 1_000_000_000, "MiB": 1_000_000, "KiB": 1_000_000]
    IO.puts binary_to_float(num) * exponents[binary_to_atom(exp)]
  end
end
 

ft = Torrent_Result.new([id: 8894478, 
  name: "Formula 1 2013 R12 Italian Grand Prix Race BBC", 
  category: "TV shows", 
  magnet: "magnet:?xt=urn:btih:457bc4f687026ea5fd821029ee2cf4d646c23bb9&dn=Formula+1+2013+R12+Italian+Grand+Prix+Race+BBC&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337", 
  uploaded: "09-08 19:18", 
  uploader: "footy", 
  size: "1.59 GiB", 
  seeders: 16, 
  leechers: 8, 
  trusted: true, 
  rank: 0])

TestBlah.size_to_float(ft)