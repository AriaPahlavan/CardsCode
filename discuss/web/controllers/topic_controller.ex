defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def new(conn, params) do
    changeset =  Topic.changeset
    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    IO.inspect(params)
#    changeset =  Topic.changeset
    render conn, "create.html"
  end
end
