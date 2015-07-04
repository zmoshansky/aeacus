defmodule Aeacus do
  @moduledoc """
    Aeacus is a simple, secure, and highly configurable authentication module
    for use with Ecto. Safely and easily authenticate identity/passwords from
    any resource.
  """

  @doc false
  def config, do: Application.get_env(:aeacus, Aeacus)
end
