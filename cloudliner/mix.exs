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
        {:opml, path: "../opml"},
        {:outline, path: "../outline"},
    ]
  end
end
