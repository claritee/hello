defmodule HelloWeb.Router do
  use HelloWeb, :router
  alias HelloWeb.Plug.BasicAuth

  pipeline :basic_auth do
    plug BasicAuth, username: "user", password: "secret"
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through [:basic_auth, :browser] # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
