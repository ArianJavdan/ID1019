defmodule Env do
    def new() do [] end
    def add(id, str, env) do [{id, str} | env] end
    def lookup(id, env) do List.keyfind(env, id, 0) end
    def remove(_, []) do [] end
    def remove(ids, env) do  
        if List.keymember?(env, ids, 0) do
            remove(ids, List.delete(env, List.keyfind(env, ids, 0)))
        
        else env
        end
    end

end