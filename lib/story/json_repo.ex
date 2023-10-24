defmodule Story.JsonRepo do
  def stories do
    read_stories()
  end

  def get(id) do
    stories = read_stories()
    story = stories |> Enum.find(fn el -> el.id == id end)
    %{count: Enum.count(stories), story: story}
  end

  defp read_stories do
    content = File.read!("priv/files/stories.json")
    stories = Jason.decode!(content, keys: :atoms)
    size = Enum.count(stories)

    Enum.zip(1..size, stories) |> Enum.map(fn {id, el} -> Map.put(el, :id, id) end)
  end
end
