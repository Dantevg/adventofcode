local data = {}

-- Read data
for line in io.lines() do
	local direction, amount = line:match("^(%w+)%s(%d+)$")
	table.insert(data, {
		direction = direction,
		amount = tonumber(amount),
	})
end

function f1()
	local h, v = 0, 0
	for _, move in ipairs(data) do
		if move.direction == "forward" then
			h = h + move.amount
		elseif move.direction == "down" then
			v = v + move.amount
		elseif move.direction == "up" then
			v = v - move.amount
		end
	end
	return h * v
end

function f2()
	local h, v, aim = 0, 0, 0
	for _, move in ipairs(data) do
		if move.direction == "forward" then
			h = h + move.amount
			v = v + move.amount * aim
		elseif move.direction == "down" then
			aim = aim + move.amount
		elseif move.direction == "up" then
			aim = aim - move.amount
		end
	end
	return h * v
end

print(f2())
