defmodule Mergesort do

	def mergesort([]) do [] end
	def mergesort([a]) do [a] end
	def mergesort(list) do

		{left, right} = split(list)

		resL = mergesort(left)

		resR = mergesort(right)

		{resL, resR}

		merge(resL, resR)

	end

	def split(list) do split(list, [], []) end

	def split([], list1, list2) do {list1, list2} end

	def split([h | tail], list1, list2) do
		split(tail, [h | list2], list1)
	end

	

	def merge([], []) do [] end

	def merge([], list) do list end
	def merge(list, []) do list end

	def merge([h1 | t1], [h2 | t2]) do
		if(h1 < h2) do
			[h1 | merge(t1, [h2 | t2])]
		else 
			[h2 | merge([h1 | t1], t2)]
		end
	end

end