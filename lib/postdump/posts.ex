defmodule Postdump.Posts do


  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end


  def get do
    Agent.get(__MODULE__, &(&1))
  end


  def add(post) do
    Agent.update(__MODULE__, &([post | &1]))
  end


end
