defmodule Aeacus do
  @moduledoc """
    A simple, secure, and highly configurable Elixir identity [username |
    email | id | etc.]/password authentication module to use with Ecto.
  """

  @default_config %{
    crypto: Comeonin.Pbkdf2,
    identity_field: :email,
    password_field: :hashed_password,
    error_message: "Invalid identity or password."
  }

  @doc false
  def config, do: Application.get_env(:aeacus, Aeacus)

  @doc """
   Decides to use the paramater passed configuration or application config.
   The result is merged with the default configuration options specified by Aeacus.
  """
  @spec default_config(Map.t) :: Map.t
  def default_config(configuration) do
    config = case Map.size(configuration) do
      0 -> config |> Enum.into %{}
      _ -> configuration
    end

    Map.merge(@default_config, config)
  end

end
