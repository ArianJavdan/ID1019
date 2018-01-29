defmodule Ovning2 do

	def deriv({:const, _}, _) do ({:const, 0}) end
	def deriv({:var, v}, {:var, v}) do ({:const, 1}) end
	def deriv({:var, y}, _) do ({:var, y}) end
	def deriv({:mul, e1, e2}, v) do simplify({:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}) end
	def deriv({:add, e1, e2}, v) do simplify({:add, deriv(e1, v), deriv(e2, v)}) end

	def simplify({:const, a}) do a end
	def simplify({:var, v}) do v end
	def simplify({:mul, a, b}, v) do {simplify(a), '*', simplify(b)} end
	def simplify({:mul, a, b}) do {simplify(a),'*', simplify(b)} end
	def simplify({:add, a, b}) do {simplify(a),'+',  simplify(b)} end
	def simplify({:add, a, b}, v) do {simplify(a),'+', simplify(b)} end

end