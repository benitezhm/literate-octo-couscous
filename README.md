# LiterateOctoCouscous

This is a sample app to demonstrate the use of authentication functionality in phoenix, the following workflows are available:

- Sign-up
- Login
- Forgot Password

If you want to run this locally do:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## How to use

From root route `/` you'll see several links, or you can use the following links

- [`Register a new user`](http://localhost:4000/users/register)
- [`Login`](http://localhost:4000/users/log_in)
- [`Forgot Password`](http://localhost:4000/users/reset_password)

### This app uses a local dev mailbox, in order to access it you can use this route in you browser [`Local Mail`](http://localhost:4000/dev/mailbox)

## Learn more

https://hexdocs.pm/phoenix/mix_phx_gen_auth.html