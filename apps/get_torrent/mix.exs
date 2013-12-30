defmodule GetTorrent.Mixfile do
  use Mix.Project

  def project do
    [ app: :get_torrent,
      version: "0.0.1",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 0.12.0",
      escript_main_module: GetTorrent.PirateBaySearch,
      name: GetTorrent,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod:                { GetTorrent, [] },
      applications:       [ :httpotion ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat.git" }
  #
  # You can depend on another app in the same umbrella with:
  # { :other, in_umbrella: true }
  defp deps do
    [
      {:httpotion,"0.2.3",[github: "myfreeweb/httpotion"]},
      {:jsonex,"2.0",[github: "marcelog/jsonex", tag: "2.0"]},
      { :ex_doc, github: "elixir-lang/ex_doc" }
    ]
  end
end
