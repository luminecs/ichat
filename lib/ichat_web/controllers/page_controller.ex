defmodule IchatWeb.PageController do
  use IchatWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
