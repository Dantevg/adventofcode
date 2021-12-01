local data = {}

-- Read data
for line in io.lines() do
	local min, max, char, pw = line:match("^(%d+)%-(%d+)%s+(%a):%s+(.+)$")
	table.insert(data, {
		min = tonumber(min),
		max = tonumber(max),
		char = char,
		pw = pw,
	})
end

function count(str, char, pos)
	local n = 0
	for _ in str:sub(pos or 1, pos or -1):gmatch(char) do
		n = n+1
	end
	return n
end

function f1()
	local amount = 0
	
	for i = 1, #data do
		local n = count(data[i].pw, data[i].char)
		if n >= data[i].min and n <= data[i].max then
			amount = amount+1
		end
	end
	
	return amount
end

function f2()
	local amount = 0
	
	for i = 1, #data do
		local n1 = count(data[i].pw, data[i].char, data[i].min)
		local n2 = count(data[i].pw, data[i].char, data[i].max)
		if n1+n2 == 1 then amount = amount+1 end
	end
	
	return amount
end

print(f2())
