defmodule StoryWeb.StoryLive.Index do
  use StoryWeb, :live_view

  alias Story.JsonRepo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :stories, JsonRepo.stories())}
  end
end
