defmodule Postdump do

  use Application

  def start(_type, _args) do

    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Postdump.Worker, [], port: 8000),
      worker(Postdump.Posts, [])
    ]

     Supervisor.start_link(children, strategy: :one_for_one)
   end

end
