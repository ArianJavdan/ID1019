defmodule Rudy do
	
	def start(port) do
		tmp = Process.register(spawn(fn -> init(port) end), :rudy)

	end
	def stop() do
		Process.exit(Process.whereis(:rudy), "Time to die!")
	end
	def init(port) do
		opt = [:list, active: false, reuseaddr: true]
		case :gen_tcp.listen(port, opt) do
			{:ok, listen} ->
				handler(listen)
				:gen_tcp.close(listen)
				:ok
			{:error, error} ->
				error
		end
	end
	def handler(listen) do
		case :gen_tcp.accept(listen) do
			{:ok, client} ->
				ref = make_ref()
				Process.register(spawn(fn -> request(client, ref) end), ref)
			{:error, error} ->
				error
		end
		handler(listen)
	end
	def request(client, ref) do
		recv = :gen_tcp.recv(client, 0)
			case recv do
			{:ok, str} ->
				temp = HTTP.parse_request(str)
				response = reply(temp)
				:gen_tcp.send(client, response)
				
			{:error, error} ->
				IO.puts("RUDY ERROR: #{error}")
			end
		:gen_tcp.close(client)

		Process.exit(Process.whereis(ref), "time to die")
		IO.puts("process terminated")
	end
	def reply({{:get, uri, _}, _, _}) do
		:timer.sleep(10)
		HTTP.ok("Hello!")
	end
end
