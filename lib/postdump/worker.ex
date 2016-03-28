defmodule Postdump.Worker do


  use Plug.Router


  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch


  post "/" do
    IO.puts("#{inspect(conn.req_headers)} \n #{inspect(conn.params)}\n\n")
    Postdump.Posts.add({conn.req_headers, conn.params})
    send_resp(conn, 200, "OK")
  end


  get "/posts" do
    page_contents = EEx.eval_file("templates/posts.eex", [posts: Postdump.Posts.get])
    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, page_contents)
  end


  match _ do
    send_resp(conn, 404, "Oops")
  end


end
