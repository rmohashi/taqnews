defmodule Taqnews.Repo do
  use Ecto.Repo,
    otp_app: :taqnews,
    adapter: Ecto.Adapters.Postgres
end
