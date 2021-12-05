local data = {}
local length = 0

-- Read data
for line in io.lines() do
	length = #line
	table.insert(data, tonumber(line, 2))
end

function getBit(number, n)
	return number >> (n-1) & 1
end

function setBit(number, n, bit)
	return number | (bit << (n-1))
end

function mostCommonBit(tbl, n)
	local amount = 0
	for _, number in ipairs(tbl) do
		amount = amount + getBit(number, n)
	end
	return (amount / #tbl >= 0.5) and 1 or 0
end

function leastCommonBit(tbl, n)
	return 1 - mostCommonBit(tbl, n)
end

function f1()
	local gamma, epsilon = 0, 0
	
	for i = 1, length do
		gamma = setBit(gamma, i, mostCommonBit(tbl, i))
		epsilon = setBit(epsilon, i, leastCommonBit(tbl, i))
	end
	
	return gamma * epsilon
end

function filter(tbl, condition)
	local filtered = {}
	for _, line in ipairs(tbl) do
		if condition(line) then table.insert(filtered, line) end
	end
	return filtered
end

function rating(common)
	local filtered = data
	
	for i = length, 1, -1 do
		local commonBit = common(filtered, i)
		filtered = filter(filtered, function(line) return getBit(line, i) == commonBit end)
		if #filtered == 1 then return filtered[1] end
	end
	
	error("should not happen")
end

function f2()
	local oxygen, co2 = rating(mostCommonBit), rating(leastCommonBit)
	return oxygen * co2
end

print(f2())
