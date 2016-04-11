defmodule Postdump.Mixfile do
  use Mix.Project

  def project do
    [app: :postdump,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end


  def application do
    [applications: [:cowboy, :logger, :plug, :poison],
     mod: {Postdump, []}]
  end


  defp deps do
    [
      {:cowboy  , "~> 1.0"},
      {:exrm    , "~> 1.0", override: true},
      {:plug    , "~> 1.1"},
      {:poison  , "~> 2.0"},
    ]
  end


end
