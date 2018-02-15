defmodule Chopstick do
    def start() do
        stick = spawn_link(fn -> available() end)
    end
    def quit(c) do 
        Process.exit(c, :kill)
    end
    def available() do
        receive do
            {:request, from} -> 
                send(from, :granted)
                gone()
            :quit -> :ok
        end
    end
    def gone() do
        receive do
            :return -> available()
            :quit -> :ok
        end
    end
    def request({:stick, pid}) do
        send(pid,{:request, self()})
        receive do
            :granted -> :ok
        end
    end
    def request({:stick, pid}, timeout) do
        send(pid, {:request, self()})
        receive do
            :granted -> :ok
                :ok
            after 
            200 ->
                IO.puts "timeout"
                :no
        end
    end
    def return({:stick, pid}) do
        send(pid, :return)
    end
end