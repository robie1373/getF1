defmodule GetTorrent.PirateBaySort do

  @ranks ["footy": 2, "tonyisaac": 3]
  def sort_results(list_of_results) do
    list_of_results
    |> rank_uploaders
  end
  


  def change_rank(torrent_record, increment) do
    initial_value   = torrent_record.rank
    torrent_record.rank(initial_value + increment)
  end

  def rank_uploaders(list) do
    # list
    do_rank_uploaders([list, []])
  end

  defp do_rank_uploaders([[], accum]) do
    accum
  end

  defp do_rank_uploaders([[head | tail], accum]) do
    case head.uploader do
      "footy"     -> do_rank_uploaders([tail, [change_rank(head, @ranks[binary_to_atom(head.uploader)]) | accum]])
      "tonyisaac" -> do_rank_uploaders([tail, [change_rank(head, @ranks[binary_to_atom(head.uploader)]) | accum]])
      _           -> do_rank_uploaders([tail, [head | accum]])
    end
  end

end