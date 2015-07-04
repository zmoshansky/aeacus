[Aeacus - The holder of keys](https://en.wikipedia.org/wiki/Aeacus)
======

A simple, secure, and highly configurable Elixir identity [username | email | id | etc.]/password authentication module to use with Ecto.

[![Build Status](https://travis-ci.org/zmoshansky/aeacus.svg)](https://travis-ci.org/zmoshansky/aeacus) [![Hex.pm](http://img.shields.io/hexpm/v/aeacus.svg)](https://hex.pm/packages/aeacus) [![Hex.pm](http://img.shields.io/hexpm/dt/aeacus.svg)](https://hex.pm/packages/aeacus) [![Github Issues](http://githubbadges.herokuapp.com/zmoshansky/aeacus/issues.svg)](https://github.com/zmoshansky/aeacus/issues) [![Pending Pull-Requests](http://githubbadges.herokuapp.com/zmoshansky/aeacus/pulls.svg)](https://github.com/zmoshansky/aeacus/pulls)

#### Description ####
Aeacus only performs authentication, making it well suited for integration with session storage, or a token system; like [Guardian](https://github.com/hassox/guardian). Alternatively, this could be used directly over a secure (HTTPS) connection with [HTTP Basic Auth](https://en.wikipedia.org/wiki/Basic_access_authentication); But, it is highly discouraged as there is a greater security risk, due to repeatedly sending your authentication information to the server, only relying on TLS for security.

#### Requirements ####
Aeacus requires that you have an Ecto model that has UNIQUE(identity_field) and password_field. These fields can be configured to easily match your schema, whether it be `username`, `email`, or `pass`, `password`, `hash`, `hashed_password`, etc. Of course, the passwords must be stored using the same crypto system as Aeacus; The password should be salted and hashed, plaintext is heavily discouraged. See the tests for examples.

#### Config ####
You must set the `:repo` and `:model` for Aeacus. The other options have sane defaults.

```
config :aeacus, Aeacus,
  repo: MyApp.Repo,
  model: MyApp.User,
  # Optional, The following are the default options
  crypto: Comeonin.Pbkdf2,
  identity_field: :email,
  password_field: :hashed_password,
  error_message: "Invalid identity or password."
```

#### Example Session Controller ####
`Aeacus.authenticate` expects a `Map` with keys `:identity`, and `:password`.

```
defmodule MyApp.SessionController do
  def create(conn, params) do
    case Aeacus.authenticate %{identity: params[:email], password: params[:pass]} do
      {:ok, user} -> CreateTokenOrCookie
      {:error, message} -> DisplayAuthenticationScreenAgain
    end
  end
end
```
