local data = {}

-- Read data
local line = io.read("l")
while line do
	table.insert(data, tonumber(line))
	line = io.read("l")
end

function reduce(fn, acc, ...)
	local values = {...}
	for i = 1, #values do
		acc = fn(acc, values[i])
	end
	return acc
end

function combi(data, depth, fn, ...)
	if depth <= 0 then return end
	for i = 1, #data do
		if depth == 1 then
			if fn({k=i, v=data[i]}, ...) then return true end
		else
			if combi(data, depth-1, fn, {k=i, v=data[i]}, ...) then return true end
		end
	end
end

function sum(...)
	return reduce(function(acc, x) return acc+x.v end, 0, ...)
end

function mul(...)
	return reduce(function(acc, x) return acc*x.v end, 1, ...)
end

combi(data, 3, function(...)
	if sum(...) == 2020 then
		print(mul(...))
		return true
	end
end)