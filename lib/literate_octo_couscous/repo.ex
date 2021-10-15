defmodule LiterateOctoCouscous.Repo do
  use Ecto.Repo,
    otp_app: :literate_octo_couscous,
    adapter: Ecto.Adapters.Postgres
end
