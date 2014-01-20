defmodule GetTorrent.DisplayCli do 

  def slice_or_pad(string, length, pad // ? ) do
    if String.length(string) > (length) do
      String.slice(string, 0, (length - 3)) <> "..."
    else
      String.ljust(string, length, pad)
    end
  end

  @field_widths [name: 54, source: 11, rank: 6, downloaded: 5]

  def format_header do
    name_header = slice_or_pad(" Name ", @field_widths[:name], ?-)
    source_header = slice_or_pad(" Source ", @field_widths[:source], ?-)
    rank_header = String.ljust(" Rank ", @field_widths[:rank], ?-)
    dl_header = String.ljust(" DL", @field_widths[:downloaded], ?-)
    "+#{name_header}+#{source_header}+#{rank_header}+#{dl_header}\n"
  end

  def format_output(processed_output) do
    do_format_output(processed_output, "")
  end

  defp do_format_output([processed_output=Torrent_Result[] | tail], accum) do
    name = " #{processed_output.name}"
      |> slice_or_pad(@field_widths[:name])
    source = String.ljust(" PirateBay", @field_widths[:source])
    rank = String.ljust(" #{processed_output.rank}", @field_widths[:rank])
    dl = String.ljust(" No", @field_widths[:downloaded])
    do_format_output(tail ,accum <> "|#{name}|#{source}|#{rank}|#{dl}\n")
  end

  defp do_format_output([_ | tail], accum) do
    do_format_output(tail, accum)
  end

  defp do_format_output([], accum) do
    accum
  end

  def prepare_for_cli(processed_output) do
    format_header <> format_output(processed_output)
  end

  def print_cli(processed_output) do
    IO.puts prepare_for_cli(processed_output)
  end

end