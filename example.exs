defmodule Example do
	def main do
		name = IO.gets("what is your name? \n") 
		IO.puts("Hello #{name}")
	end
end