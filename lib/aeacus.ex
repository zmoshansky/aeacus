defmodule Aeacus do
  @moduledoc """
    A simple, secure, and highly configurable Elixir identity [username |
    email | id | etc.]/password authentication module to use with Ecto.
  """

  @doc false
  def config, do: Application.get_env(:aeacus, Aeacus)
end
