defmodule Ichat.Repo do
  use Ecto.Repo,
    otp_app: :ichat,
    adapter: Ecto.Adapters.Postgres
end
