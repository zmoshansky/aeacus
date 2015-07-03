defmodule AeacusTest do
  use ExUnit.Case, async: true

  defmacro config_helper(key) do
    quote do
      Application.get_env(:aeacus, Aeacus)
      |> Dict.get(unquote(key))
    end
  end

  test "config values for this project" do
    assert config_helper(:repo) == Aeacus.Repo
    assert config_helper(:model) == Aeacus.Test.MockResource
  end

  test "default config values, inherited by projects using Aeacus" do
    assert config_helper(:crypto) == Comeonin.Pbkdf2
    assert config_helper(:identity_field) == :email
    assert config_helper(:password_field) == :hashed_password
    assert config_helper(:error_message) == "Invalid identity or password."
  end
end
