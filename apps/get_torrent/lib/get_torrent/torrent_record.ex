defrecord Torrent_Result, id: 0, name: "", category: "",
  magnet: "", uploaded: "", uploader: "", size: 0, seeders: 0,
  leechers: 0, trusted: false, rank: 0 do
  
    def bsize(record) do
      exponents = ["GiB": 1_000_000_000, "MiB": 1_000_000, "KiB": 1_000_000]
      [num, exp] = String.split(record.size)
      binary_to_float(num) * exponents[binary_to_atom(exp)]
    end

  end
