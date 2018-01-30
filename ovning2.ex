defmodule Ovning2 do

	def test(charlist) do 
		
		
	end

	def deriv({:const, _}, _) do ({:const, 0}) end
	def deriv({:var, v}, {:var, v}) do ({:const, 1}) end
	def deriv({:var, y}, _) do ({:var, y}) end
	def deriv({:mul, e1, e2}, v) do {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}} end
	def deriv({:add, e1, e2}, v) do {:add, deriv(e1, v), deriv(e2, v)} end

	def simplify({:const, a}) do a end
	def simplify({:var, v}) do v end
	def simplify({:mul, a, b}, v) do [simplify(a), '*', simplify(b)] end
	def simplify({:mul, a, b}) do [simplify(a),'*', simplify(b)] end
	def simplify({:add, a, b}) do [simplify(a),'+',  simplify(b)] end
	def simplify({:add, a, b}, v) do [simplify(a),'+', simplify(b)] end

	def oversimplify([a, b, c]) when (is_integer(a) and is_integer(c)) do
		case b do
		'*' -> a*c
		'+' -> a+c
		end
	end
	def oversimplify([a, b, c]) when (is_integer(a)) do
		case{a, b} do
			{0, '+'} -> "#{c}"
			{0, '*'} -> "" 
			{a,'*'} -> "#{a}#{c}"
			{a,'+'} -> "(#{a}+#{c}) "
		end
	end

	def oversimplify([a, b, c]) when (is_integer(c)) do
		
		case {c,b} do
			{0, '+'} -> "#{a}"
			{0, '*'} -> "" 
			{c,'*'} -> "#{c}#{a}"
			{c,'+'} -> "(#{c}+#{a}) "
		end
	end

	def oversimplify([a, b, c]) do oversimplify([oversimplify(a)] ++[b] ++[oversimplify(c)]) end
	#def oversimplify([_, '*', 0]) do [] end
	#def oversimplify([0, '*', _]) do [] end
	##def oversimplify([a, '+', 0]) do a end
	#def oversimplify([0, '+', a]) do a end
	#def oversimplify(a) do a end'
	
	
end