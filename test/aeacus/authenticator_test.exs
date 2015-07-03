defmodule Aeacus.AuthenticatorTest do
  use ExUnit.Case
  use Aeacus.Test.Helper

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Aeacus.Repo, [])
    end

    :ok
  end

  test "authenticate with app config" do
    assert_ok Authenticator.authenticate nil, %{identity: @email, password: @password}
  end

  test "authenticate with custom params" do
    assert_ok Authenticator.authenticate nil,
    %{identity: @username,
      password: @password},
    %{repo: Aeacus.Repo,
      model: Aeacus.Test.MockCustomResource,
      crypto: Comeonin.Pbkdf2,
      identity_field: :username,
      password_field: :pass,
      error_message: "Invalid identity or password."
    }
  end

  test "authenticate returns the resource" do
    {:ok, resource} = Authenticator.authenticate nil, %{identity: @email, password: @password}
    assert resource.__struct__ == MockResource
    assert resource.email == @email
  end

  test "default error message" do
    {:error, message} = Authenticator.authenticate nil, %{identity: @bad_identity, password: @password}
    assert message == "Invalid identity or password."
  end

  test "custom error message" do
    {:error, message} = Authenticator.authenticate nil,
    %{identity: @bad_identity,
      password: @password},
    %{repo: Aeacus.Repo,
      model: Aeacus.Test.MockCustomResource,
      crypto: Comeonin.Pbkdf2,
      identity_field: :username,
      password_field: :pass,
      error_message: "Not the droids I was looking for"
    }
    assert message == "Not the droids I was looking for"
  end

  test "authenticate fails if resource doesn't exist" do
    assert_error Authenticator.authenticate nil, %{identity: @bad_identity, password: @password}
  end

  test "authenticate fails if password is incorrect" do
    assert_error Authenticator.authenticate nil, %{identity: @email, password: @bad_password}
  end
end
