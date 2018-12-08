defmodule TaqnewsWeb.Router do
  use TaqnewsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaqnewsWeb do
    pipe_through :api
  end
end
