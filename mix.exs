defmodule Unidekode.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :unidekode,
      version: @version,
      elixir: "~> 1.7",
      name: "Unidekode",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp description do
    """
    Blazing fast and zero dependencies decoding of unicode strings to US-ASCII strings
    """
  end

  defp package do
    [
      maintainers: ["Benjamin Schultzer"],
      licenses: ["MIT"],
      links: links(),
      files: [
        "lib", "priv", "config", "mix.exs", "README*", "CHANGELOG*", "LICENSE*"
      ]
    ]
  end

  defp docs() do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: "https://github.com/schultzer/unidekode"
    ]
  end

  def links do
    %{
      "GitHub"    => "https://github.com/schultzer/unidekode",
      "Readme"    => "https://github.com/schultzer/unidekode/blob/v#{@version}/README.md",
      "Changelog" => "https://github.com/schultzer/unidekode/blob/v#{@version}/CHANGELOG.md"
    }
  end

end
