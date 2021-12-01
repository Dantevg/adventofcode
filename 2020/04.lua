local data = {}

-- Read data
function readPassport()
	local p = {}
	local line = io.read("l")
	while line and line ~= "" do
		for k, v in line:gmatch("(%a+):([^%s]+)") do
			p[k] = v
		end
		line = io.read("l")
	end
	table.insert(data, p)
	return line
end

repeat
	local l = readPassport()
until not l

function has(p, ...)
	local keys = {...}
	for i = 1, #keys do
		if not p[keys[i]] then return false end
	end
	return true
end

function validateFields(p)
	return has(p, "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid")
end

function validateByr(p)
	local n = tonumber(p.byr)
	return #p.byr == 4 and n and tonumber(p.byr) >= 1920 and tonumber(p.byr) <= 2002
end

function validateIyr(p)
	local n = tonumber(p.iyr)
	return #p.iyr == 4 and n and tonumber(p.iyr) >= 2010 and tonumber(p.iyr) <= 2020
end

function validateEyr(p)
	local n = tonumber(p.eyr)
	return #p.eyr == 4 and n and tonumber(p.eyr) >= 2020 and tonumber(p.eyr) <= 2030
end

function validateHgt(p)
	local n_cm = p.hgt:match("(%d+)cm")
	local n_in = p.hgt:match("(%d+)in")
	if n_cm then
		return tonumber(n_cm) >= 150 and tonumber(n_cm) <= 193
	elseif n_in then
		return tonumber(n_in) >= 59 and tonumber(n_in) <= 76
	else
		return false
	end
end

function validateHcl(p)
	return p.hcl:match("#%x%x%x%x%x%x")
end

function validateEcl(p)
	return p.ecl == "amb" or p.ecl == "blu" or p.ecl == "brn" or p.ecl == "gry"
		or p.ecl == "grn" or p.ecl == "hzl" or p.ecl == "oth"
end

function validatePid(p)
	return #p.pid == 9 and not p.pid:match("[^%d]")
end

function validateAll(p)
	if not validateFields(p) then return 0 end
	if not validateByr(p) then return 0 end
	if not validateIyr(p) then return 0 end
	if not validateEyr(p) then return 0 end
	if not validateHgt(p) then return 0 end
	if not validateHcl(p) then return 0 end
	if not validateEcl(p) then return 0 end
	if not validatePid(p) then return 0 end
	return 1
end

function f1()
	local count = 0
	for i = 1, #data do
		if validateFields(data[i]) then count = count+1 end
	end
	return count
end

function f2()
	local count = 0
	for i = 1, #data do
		count = count+validateAll(data[i])
	end
	return count
end

print(f2())
