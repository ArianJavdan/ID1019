defmodule Test do
	def double(n) do
		 n * 2
	end
	def temperature(f) do
		IO.puts("#{f} in Celcius is #{(f - 32)/1.8}")
	end

	def rectangle(l,w) do
		IO.puts("Length = #{l}, Width =  #{w}, Area = #{w * l}")
	end

	def square(l,w) do 
		IO.puts("Length = #{l}, Width =  #{w}, Area = #{w * l}")
	end

	def circle(r) do
		IO.puts("Radius = #{r}, Area = #{ 3.14 * r * r}")
	end

	def produkt(m,n) do
		if(m == 0) do
			0
		else 
			 n +  produkt(m-1, n)
			 
		end
	end

	def exp(x,y) do
		if (y == 1) do
			x	
		end

		if(y == 0) do
			1		  
		
		else
			case rem(y,2) do
				0 -> produkt(x,exp(x,div(y,2)-1)) * produkt(x,exp(x,div(y,2)-1))
				1 -> produkt(x,exp(x,y-1))

			end

		end

	end

	def nth(1, list) do (hd list ) end
	def nth(n, list) do nth(n-1, list -- [hd list]) end
	
	def len([]) do 0 end	
	def len(list) do 1 + len(list -- [hd list]) end

	def sum([]) do 0 end	
	def sum(list) do (hd list) + sum(list -- [hd list]) end

	def duplicate([a]) do [a, a] end
	def duplicate(l) do [(hd l) , (hd l)] ++ duplicate(l -- [hd l]) end
		
	def add(x, l) do
	l = l -- [x]
	[x | l]
	end	

	def remove(x, [a]) do 
		if (a != x) do
		   [a]
		else 
			[]
		end
	end

	def remove(x, l) do
		  
		case (hd l) == x do

		   true ->  remove(x, l -- [hd l])
		   false -> [hd l] ++ remove(x, l -- [hd l])  
		end
	end

	def unique([], a) do a end
	def unique(l, n) do
		k = add((hd l), n)
		unique( (tl l), k)	
	end
	def unique(l) do unique(l , []) end

	def pack([]) do [] end
	def pack(l) do
		temp = remove((hd l), l)
		[l -- temp | pack(temp)]
	end

	def reverse([], a) do a	end
	def reverse(l, a) do
		k =  [hd l] ++ a
		l = l -- [hd l]
		reverse(l, k)
	end
	def reverse(l) do
		reverse(l, [])
	end

	def inserta(e, [], k) do (k ++ [e]) end
	def inserta(e, l, k) do
		if (e > (hd l))  do
		  inserta(e, l -- [hd l], k ++ [hd l])
		  else
		  	k ++ [e | l]
		end
	end
	def insert(e, l) do
		inserta(e, l, [])	
	end

	def isort([], sorted) do sorted end
	def isort(list, sorted) do
		sorted = insert((hd list), sorted)
		isort(list -- [hd list], sorted)
	end
	def isort(list) do isort(list, []) end

	def msort([a]) do [a] end
	def msort(l) do
		{l1, l2} = msplit(l, [], [])
		merge(msort(l1), msort(l2))
	end
	def merge([], l) do l end
	def merge(l, []) do l end
	def merge(l1, l2) do
		if ((hd l1)  < (hd l2)) do 
			[hd l1] ++ merge((tl l1), l2)
		else
			[hd l2] ++ merge(l1, (tl l2))
		end
	end

	def msplit([], l1, l2) do {l1, l2} end
	def msplit([a], l1, l2) do {l1++[a] , l2} end
	def msplit(l, l1, l2) do msplit((tl (tl l)), l1 ++ [(hd l)] , l2 ++[(hd (tl l))])	end

	def qsort([]) do [] end
	def qsort([p | l]) do
		{small, large} = qsplit(p, l, [], [])
		
		append(small, [p | large])
	end
	def qsplit(_, [], small, large) do {small, large} end
	def qsplit(p, [h | t], small, large) do
		if h < p do
			qsplit(p, t, [h | small], large)
			else
			qsplit(p, t, small, [h | large])
		end
	end
	
	def append(l1, l2) do 
		l1 ++ l2 end	
end