defmodule Aeacus do
  @moduledoc """
    Aeacus is a simple, secure, and highly configurable authentication module
    for use with Ecto. Safely and easily authenticate identity/passwords from
    any resource.
  """

  @doc false
  def config, do: Application.get_env(:aeacus, Aeacus)
end

defmodule Guardian.Authenticator do
  use Behaviour

  @doc "Runs an authentication strategy and returns the resource if successful"
  defcallback authenticate(conn :: Plug.Conn.t, params :: term) :: { :ok, resource :: term } | { :error, String.t }
end
