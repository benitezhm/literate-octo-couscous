defmodule LiterateOctoCouscousWeb.PageController do
  use LiterateOctoCouscousWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
