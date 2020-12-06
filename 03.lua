local data = {}

-- Read data
for line in io.lines() do
	local row = {}
	for c in line:gmatch(".") do
		table.insert(row, c == "#")
	end
	table.insert(data, row)
end

function mod(v, m)
	return ((v-1) % m) + 1
end

function isTree(map, x, y)
	if y > #map then return 0 end
	return map[y][mod(x, #data[1])] and 1 or 0
end

function traverse(map, to, x, y, dx, dy)
	if y >= to then
		return 0
	else
		return isTree(map, x, y) + traverse(map, to, x+dx, y+dy, dx, dy)
	end
end

function f1()
	return traverse(data, #data+1, 1, 1, 3, 1)
end

function f2()
	local slopes = {{1,1}, {3,1}, {5,1}, {7,1}, {1,2}}
	local val = 1
	for _, slope in ipairs(slopes) do
		val = val * traverse(data, #data+1, 1, 1, slope[1], slope[2])
	end
	return val
end

print(f2())
