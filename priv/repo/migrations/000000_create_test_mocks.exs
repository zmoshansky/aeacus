defmodule Repo.CreateTestMocks do
  use Ecto.Migration

  def change do
    create table(:default_resource) do
      add :email,           :string
      add :hashed_password, :string
    end

    create table(:custom_resource) do
      add :username,  :string
      add :pass,      :string
    end

    create index(:default_resource, [:email], unique: true)
    create index(:custom_resource, [:username], unique: true)
  end
end