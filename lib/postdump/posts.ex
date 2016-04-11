defmodule Postdump.Posts do


  def start_link do
    Agent.start_link(
      fn ->
        file = File.open! "posts.txt", [:write]
        {[], file}
      end,
      name: __MODULE__
    )
  end


  def get do
    Agent.get(__MODULE__,
      fn {posts, _file} ->
        posts
      end
    )
  end


  def add({headers, params}) do
    Agent.update(__MODULE__,
      fn {posts, file} ->
        file
        |> IO.binwrite(params["_json"] |> Poison.encode!)
        file
        |> IO.binwrite("\n")
        new_posts = [{headers, params} | posts] |> Enum.take(100)
        {new_posts, file}
      end
    )
  end


end
