defmodule TidalWave.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tidal_wave,
      version: "0.1.0",
      elixir: "~> 1.5",
      escript: [main_module: TidalWave],
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      { :uuid, "~> 1.1" },
      {:xml_builder, "~> 0.1.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
