defmodule Eager do
    def eval_expr({:atm, id},env) do {:ok, id} end
    def eval_expr({:var, id}, env) do

        case List.keyfind(env, id, 0) do
            nil ->
                :error
            {_, str} ->
                {:ok, str}
        end
    end
    def eval_expr({:cons, head, tail}, env) do
        case eval_expr(head, env) do
            :error ->
                :error
            {:ok, str} ->
                case eval_expr(tail, env) do
                    :error ->
                        :error
                    {:ok, ts} ->
                        {:ok, [str | ts]}
                end
            
        end
    end
    def eval_match(:ignore, data, env) do
        {:ok, env}
    end
    def eval_match({:atm, id}, data, env) do
        {:ok, env}
    end
    def eval_match({:var, id}, str, env) do
        case Env.lookup(id, env) do
            nil ->
                {:ok, [{id, str} | env]}
            {_, ^str} ->
                {:ok, env}
            {_, _} ->
                :fail
        end
    end
    def eval_match({:cons, head, tail}, [h | t], env) do
        case eval_match(head, h, env) do
            :fail ->
                :fail
            {:ok, env} ->
                eval_match(tail, t, env)
        end
    end
    def extract_vars(a) do extract_vars(a, []) end
   def extract_vars({:atm, _}, vars) do vars end
  def extract_vars(:ignore, vars) do vars end
  def extract_vars({:var, var}, vars) do
    [var | vars]
  end
  def extract_vars({:cons, head, tail}, vars) do
    extract_vars(tail, extract_vars(head, vars))
  end
    def eval_seq([exp], env) do
        eval_expr(exp, env)
    end
    def eval_seq([{:match, pat, exp} | seq  ], env) do
        case eval_expr(exp, env) do
            :error ->
                :error
            {:ok, str} ->
                vars = extract_vars(pat)
                env = Env.remove(vars, env)
                case eval_match(pat, str, env) do
                    :fail ->
                        :error
                    {:ok, env} ->
                        eval_seq(seq, env)
                end
        end
    end
    def eval(seq) do eval_seq(seq, []) end    
end