-- Combines CS350 Sorts

local socket = require("socket.core")

--------------------------------------------------------------------------------------------------- Insertion Sort
local function bins(tb, val, st, en)
  local st, en = st or 1, en or #tb
  local mid = math.floor((st + en)/2)
  if en == st then return tb[st] > val and st or st+1
  else return tb[mid] > val and bins(tb, val, st, mid) or bins(tb, val, mid+1, en)
  end
end

local function isort(t)
  local ret = {t[1], t[2]}
  for i = 3, #t do
    table.insert(ret, bins(ret, t[i]), t[i])
  end
  return ret
end
---------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------- Merge Sort
local function getLower(a, b)
  local i, j = 1, 1
  return function() 
    if not b[j] or a[i] and a[i]<b[j] then
      i = i + 1; return a[i-1]
    else
      j = j + 1; return b[j-1]
    end
  end  
end
 
local function merge(a, b)
  local res = {}
  for v in getLower(a, b) do res[#res+1] = v end
  return res
end
 
local function mergesort(list)
  if #list <= 1 then return list end
  local s = math.floor(#list/2)
  return merge(mergesort{table.unpack(list, 1, s)}, mergesort{table.unpack(list, s+1)})
end
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------\
local function timer(list)
	sample = {}
	for i = 1, 3 do
		::fAgain::
		start = socket.gettime()
		mergesort(list)
		sample[i] = socket.gettime() - start
		if sample[i] == 0 then
			goto fAgain
		end
	end
	mTime = (sample[1] + sample[2] + sample[3])/3
	--mTime = math.floor(((sample[1] + sample[2] + sample[3])/3) * 1000000 + 0.5) / 1000000
	for i = 1, 3 do
		::sAgain::
		start = socket.gettime()
		isort(list)
		sample[i] = socket.gettime() - start
		if sample[i] == 0 then
			goto sAgain
		end
	end
	iTime = (sample[1] + sample[2] + sample[3])/3
	--iTime = math.floor(((sample[1] + sample[2] + sample[3])/3) * 1000000 + 0.5) / 1000000
	return mTime, iTime
end
---------------------------------------------------------------------------------------------------

ITER = 50000
timeRecord = {}
local aIndex = 0
local i = 50
local multiplier = 200
while i < ITER do
	if i%3 == 0 then
		print("Array Size: " .. i)
	end
	
	aIndex = aIndex + 1
	list = {}
	for j = 1, i do
		list[j] = math.random(1, 10000)
	end
	timeRecord[aIndex] = {}
	timeRecord[aIndex].aSize = i
	timeRecord[aIndex].mTime, timeRecord[aIndex].iTime = timer(list)
	
	if i > 10000 then
		multiplier = multiplier * 1.5
		i = math.floor(i + multiplier)
	else
		i = i + 50
	end
end

--[[
for k = 1, aIndex do
	print("Index " .. k .. ":\t" .. "{" .. timeRecord[k].mTime .. ", " .. timeRecord[k].iTime .. "}")
end
]]--

local file = io.open("input.txt", "a")
for k = 1, aIndex do
	toAppend = timeRecord[k].aSize .. " " .. timeRecord[k].mTime .. " " .. timeRecord[k].iTime .. "\n"
	file:write(toAppend)
end
file:close()
print("Done.")





































