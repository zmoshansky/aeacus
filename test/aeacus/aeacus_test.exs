defmodule AeacusTest do
  use ExUnit.Case, async: true
  use Aeacus.Test.Helper

  test "config values for Aeacus Testing" do
    config = Aeacus.config %{}
    assert config.repo == Aeacus.Test.Repo
    assert config.model == Aeacus.Test.MockResource
  end

  test "default config values, inherited by projects using Aeacus" do
    config = Aeacus.config %{}
    assert config.crypto == Comeonin.Pbkdf2
    assert config.identity_field == :email
    assert config.password_field == :hashed_password
    assert config.error_message == "Invalid identity or password."
  end

  test "parameter config is selected instead of application config" do
    config = Aeacus.config %{repo: "b"}
    assert config.repo == "b"
    assert_raise(KeyError, config.model)
    |> catch_error()
  end

  test "parameter config has a higher precedence than default config" do
    config = Aeacus.config %{repo: "b", identity_field: :foo}
    assert config.repo == "b"
    assert config.identity_field == :foo
  end

  test "delegates authenticate/1 to Aeacus.Authenticator" do
    {:ok, resource} = Aeacus.authenticate %{identity: @email, password: @password}
    assert resource.__struct__ == MockResource
    assert resource.email == @email
  end

  test "delegates authenticate/2 to Aeacus.Authenticator" do
    {:ok, resource} = Aeacus.authenticate %{identity: @email, password: @password}, %{}
    assert resource.__struct__ == MockResource
    assert resource.email == @email
  end

  test "delegates authenticate_resource/2 to Aeacus.Authenticator" do
    user = Repo.get_by(MockResource, email: @email)
    assert_ok Aeacus.authenticate_resource user, %{identity: @email, password: @password}
  end

  test "delegates authenticate_resource/3 to Aeacus.Authenticator" do
    user = Repo.get_by(MockResource, email: @email)
    assert_ok Aeacus.authenticate_resource user, %{identity: @email, password: @password}, %{}
  end

end
