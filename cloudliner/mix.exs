defmodule Cloudliner.MixProject do
  use Mix.Project

  def project do
    [
      app: :cloudliner,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
    ]
  end

  defp escript do
    [main_module: Cloudliner]
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
      {:sweet_xml, "~> 0.6.6"},
      {:yaml_elixir, "~> 2.5"},
      {:exoml, "~> 0.0.10"},
    ]
  end
end
