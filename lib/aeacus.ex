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

  defdelegate authenticate(params), to: Aeacus.Authenticator
  defdelegate authenticate(params, configuration), to: Aeacus.Authenticator
  defdelegate authenticate_resource(resource, password), to: Aeacus.Authenticator
  defdelegate authenticate_resource(resource, password, configuration), to: Aeacus.Authenticator

  @doc """
  Decides to use the override_config or application config.
  The result is merged with the default configuration options specified by Aeacus.
  """
  @spec config(Map.t) :: Map.t
  def config(override_config) do
    configuration = if Enum.empty?(override_config) do
      Enum.into(Application.get_env(:aeacus, Aeacus), %{})
    else
      override_config
    end

    Map.merge(@default_config, configuration)
  end
end
