local data = {}

-- Read data
for line in io.lines() do
	table.insert(data, tonumber(line))
end

function window(n, i)
	local sum = 0
	for offset = 0, n-1 do
		sum = sum + data[i+offset]
	end
	return sum
end

function f(windowsize)
	local n = 0
	for i = 1, #data-windowsize do
		if window(windowsize, i+1) > window(windowsize, i) then n = n+1 end
	end
	return n
end

print(f(3))
