defmodule Huffman do
	def sample do
	'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text do 'this is something that we should encode' end
	def test do
		sample = sample()
		tree = tree(sample)
		encode = encode_table(tree)
		decode = decode_table(tree)
		text = text()
		seq = encode(text, encode)
		decode(seq, decode)
	end

	def tree(sample) do
		freq = freq(sample)
		huffman(freq)
	end
	
	def freq(sample) do 
		freq(sample, [])
	end
	def freq([], freq) do
		freq
	end
	def freq([char | rest], freq) do
		freq(rest, update(char, freq))
	end

	def update(char, []) do [{char, 1}] end
	def update(a, [{char, n} | tail]) do
		if a == char do 
			[{char,n + 1} | tail]
		else
		 [{char, n} | update(a, tail)]	
		end 
	end

	def huffman(freq) do
		l1 = Enum.sort(freq, fn({_, a}, {_, b}) -> a < b end )
		tree = huffmantree(l1)
	end
	
	def insert([], {a, b}), do: [{a, b}] 
	def insert([{k, a} | rest ], {b , c}) do
		if c < a do
			[{b, c}, {k, a} | rest]
		else 
			[{k, a}| insert(rest, {b, c})]	
		end	
	end

	def huffmantree([{tree, _}]) do tree end
	def huffmantree([{a, a1}, {b, b1} | rest]) do
		huffmantree(insert(rest, {{a, b}, a1+b1}))
	end

	def encode_table(tree) do
		encodea(tree, [])
	end

	def	encodea({a, b}, code) do
		l1 =encodea(a, [0|code])
		l2 = encodea(b, [1|code])
		l1 ++ l2
	end

	def encodea(a, code) do
		[{a, Enum.reverse(code)}]
	end

	def decode_table(tree) do
		encodea(tree, [])
	end

	def encode([], _) do [] end
	def encode([char | tail], table) do
		{_, code} = List.keyfind(table, char, 0)
		code ++ encode(tail, table)
	end
	

	def decode([], _) do [] end
	def decode(seq, table) do
		{char, rest} = decode_char(seq, 1, table)
		[char | decode(rest, table)]
	end
	def decode_char(seq, n, table) do
		{code, rest} = Enum.split(seq, n)
		case List.keyfind(table, code, 1) do
			{char, _} -> {char, rest}

			nil ->
				decode_char(seq, n+1, table);
	
		end
	end
end