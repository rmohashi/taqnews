defmodule TaqnewsWeb.Router do
  use TaqnewsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaqnewsWeb do
    pipe_through :api
    resources "/weeks", WeekController, except: [:new, :edit] do
      resources "/posts", PostController, except: [:new, :edit] do
        resources "/comments", CommentController, except: [:new, :edit, :update]
      end
    end
  end
end
