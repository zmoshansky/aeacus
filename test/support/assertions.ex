defmodule Aeacus.Test.Assertions do
  @moduledoc """
    Unwraps the authentication results and assert {:ok, _} | {:error, _}
  """

  defmacro assert_ok(arg) do
    quote do
      case unquote(arg) do
        {:ok, _} -> assert(true)
        {:error, e} -> assert(false, e)
      end
    end
  end

  defmacro assert_error(arg) do
    quote do
      case unquote(arg) do
        {:ok, o} -> assert(false, o)
        {:error, _} -> assert(true)
      end
    end
  end
end
