defmodule GetTorrent.PirateBayFilter do
    
  def filter_results([ [], accum ]) do
    accum
  end

  def filter_results([ [head | tail], accum ]) do
    if head.category == "TV shows" do
      filter_results([tail, [head | accum] ])
    else
      filter_results([tail, accum])
    end
  end
  
  def filter_results(list) do
    filter_results([list, [] ])
  end

end