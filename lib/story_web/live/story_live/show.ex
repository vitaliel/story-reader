defmodule StoryWeb.StoryLive.Show do
  use StoryWeb, :live_view

  alias Story.JsonRepo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id_str}, _, socket) do
    id = String.to_integer id_str
    %{count: count, story: story} = JsonRepo.get(id)
    {:noreply,
      socket
      |> assign(:story, story)
      |> assign(:story_count, count)
      |> assign(:page_title, story.title)
    }
  end
end
