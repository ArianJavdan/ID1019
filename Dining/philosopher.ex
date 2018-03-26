defmodule Philosopher do
    def sleep(t) do
        :timer.sleep(:rand.uniform(t))
    end
    def start(h, r, l, name, ctrl) do
        spawn_link(fn -> dreaming(h, r, l, name, ctrl)end)
    end
    def dreaming(0, right, left, namem ,ctrl) do  send(ctrl, :done) end
    def dreaming(hunger, right, left, name, ctrl) do
        sleep(200)
        IO.puts("#{name} has stopped dreaming")
        waiting(hunger, right, left, name, ctrl)
    end
    def waiting(hunger, right, left, name, ctrl) do
        
        case Chopstick.request({:stick, left}, 200) do
            :no ->
            Chopstick.return({:stick, left})
            dreaming(hunger, right, left, name, ctrl)
            :ok -> 
                IO.puts("#{name} received a chopstick!")
                
                case Chopstick.request({:stick, right}, 200) do
                    :no -> 
                    Chopstick.return({:stick, left})
                    Chopstick.return({:stick, right})
                    dreaming(hunger, right, left, name ,ctrl)
                    :ok -> 
                        IO.puts("#{name} received a chopstick!")
                        eating(hunger, right, left, name, ctrl)
                end
        end
    end
    def eating(hunger, right, left, name, ctrl) do
        sleep(200)
        Chopstick.return({:stick, right})
        Chopstick.return({:stick, left})
        IO.puts("#{name} returned both sticks")
        dreaming(hunger - 1, right, left, name, ctrl)
    end
end