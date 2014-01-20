defmodule GetTorrent.DisplayCliTest do
  use ExUnit.Case, async: false
  import ExUnit.CaptureIO

  import GetTorrent.HelperFunctions

  import GetTorrent.DisplayCli, only: [prepare_for_cli: 1]
  @desired_result """
  + Name ------------------------------------------------+ Source ---+ Rank + DL--
  | Formula 1 2013 The F1 Show Season Review.SkyF1       | PirateBay | 0    | No  
  | Formula 1 2013 R09 German Grand Prix Race            | PirateBay | 2    | No  
  """

  test "cli output is displayed nicely" do
    assert String.slice(capture_io(fn -> IO.puts prepare_for_cli(processed_result) end), 0, 243) == @desired_result
  end

end