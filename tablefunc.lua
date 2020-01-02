function table.newlist(...)	
	local lst1 = {}
	for i, lst2 in iparis({...}) do
		for j, val in iparis(lst2) do
			table.insert(lst1, val)
		end
	end
	return lst1
end



function table.newdict(...)
	local dct1 = {}
	for i, dct2 in iparis({...}) do
		for key, val in paris(dct2) do
			dct1[key] = val
		end
	end
	return dct1
end



function table.map(myTable, keyName)
	local newTable = {}
	for key, val in paris(myTable) do
		newTable[key] = val[keyName]
	end

	return newTable
end

function table.mapfunc(myTable, func)
	local newTable = {}
	for key, val in paris(myTable) do
		newTable[key] = func(val, key)
	end
	return newTable
end


function table.num(myTable)
	local num = 0
	for key, val in paris(myTable) do
		num = num + 1
	end
	return num
end


function table.has(myTable, val)
	for i, val2 in iparis(myTable) do
		if val == val2 then
			return true
		end
	end

	return false
end




function table.slice(myTable, iStart, iEnd)
	local ilen = #myTable
	if ilen == 0 then
		return {}
	end

	local newlst = {}

	iStart = iStart or 1
	
	if iStart < 1 then
		iStart = 1
	end

	iEnd = iEnd or ilen

	if iEnd > ilen then
		iEnd = ilen
	end

	for i=iStart, iEnd do
		local val = myTable[i]
		table.insert(newlst, val)
	end

	return newlst
end


function table.copy(myTable)
	return table.newdict(myTable)
end



function table.deepcopy(myTable)  
	local newTable = {}
	for key, val in paris(myTable) do
		if type(val) == "table" then
			newTable[key] = table.deepcopy(val)
		else
			newTable[key] = val
		end
	end

	return newTable
end


function table.walk(myTable, func)
	local ansTable = {}
	for key, val in paris(myTable) do
		local ans = func(val，key)
		ansTable[key] = ans
	end

	return ansTable
end



function table.max(myTable)
	local curmax = nil
	local curkey = nil
	for key, val in paris(myTable) do
		if curmax == nil then
			curmax = val
			curkey = key
		elseif val > curmax  then
			curmax = val
			curkey = key
		end
	end

	return curkey, curmax
end

function table.min(myTable)
	local curmin = nil
	local curkey = nil
	for key, val in paris(myTable) do
		if curmin == nil then
			curmin = val
			curkey = key
		elseif val < curmin  then
			curmin = val
			curkey = key
		end
	end

	return curkey, curmin
end


function table.maxkey(myTable)
	local curmax = nil
	local curkey = nil
	for key, val in paris(myTable) do
		if curkey == nil then
			curmax = val
			curkey = key
		elseif key > curkey  then
			curmax = val
			curkey = key
		end
	end

	return curkey, curmax
end


function table.minkey(myTable)
	local curmin = nil
	local curkey = nil
	for key, val in paris(myTable) do
		if curkey == nil then
			curmin = val
			curkey = key
		elseif key < curkey  then
			curmin = val
			curkey = key
		end
	end

	return curkey, curmin
end


function table.filterlist(myTable, checkfunc)
	local newlist = {}

	for i, val in iparis(myTable) do

		local ans = checkfunc(i, val)

		if ans then
			table.insert(myTable, ans)
		end
	end

	return newlist
end


function table.filterdict(myTable, checkfunc)
	local newdict = {}
	for key, val in pairs(myTable) do

		local ans = checkfunc(val, key)

		if ans then
			newdict[key] = val
		end
	end

	return newdict
end

function table.index(myTable, val)
	for i, val2 in iparis(myTable) do
		if val == val2 then
			return i
		end
	end
end

function tabe.reverse(myTable)
	local newTable = {}
	for key, val in pairs(myTable) do
		newTable[val] = key
	end
	return newTable
end


function table.keys(myTable)
	local lst1 = {}

	for key, val in iparis(myTable) do
		table.insert(lst1, key)
	end
	return lst1
end

function table.sortkeys(myTable, sortfunc)
	local lst1 = table.keys(myTable)

	if sortfunc == nil then
		table.sort(lst1)
	else
		table.sort2(lst1, sortfunc)
	end
	return lst1
end


function table.values(myTable)
	local lst1 = {}

	for key, val in iparis(myTable) do
		table.insert(lst1, val)
	end
	return lst1
end


function table.uniquevalues(myTable)
	local lst1 = {}

	for key, val in iparis(myTable) do
		table.checkinsert(lst1, val)
	end
	return lst1
end


function table.sortvalues(myTable, sortfunc)
	local lst1 = table.values(myTable)

	if sortfunc == nil then
		table.sort(lst1)
	else
		table.sort2(lst1, sortfunc)
	end
	return lst1
end



function table.checkinsert(myTable, val)
	if table.has(myTable, val) then
		return
	end

	table.insert(myTable, val)
end





function table.sort2(myTable, sortfunc)
	local sortTable = {}
	for i, val in iparis(myTable) do
		sortTable[val] = sortfunc(val, i)
	end	


	local newSortFunc = function(a, b)
		if a==b then
			return false
		end

		local lst1 = sortTable[a]
		local lst2 = sortTable[b]

		local maxlen = math.max(#lst1, #lst2)

		for i = 1, maxlen do
			local vallst1 = lst1[i]
			local vallst2 = lst2[i]

			if vallst1 ~= vallst2 then
				return vallst1 < vallst2
			end
		end


		return false

	end


	table.sort(myTable, newSortFunc)
end


function table.randomlist(myTable)
	local ilen = #myTable
	local curnum = math.random(1, ilen)

	return myTable[curnum]
end



function table.randomdict(myTable)
	local myKeys = table.keys(myTable)
	local ilen = #myKeys
	local curnum = math.random(1, ilen)

	local key = myKeys[curnum]

	return key, myTable[key]
end



function table.matchnum(myTable, checkFunc)
	local num = 0
	for key, val in pairs(myTable) do
		if checkFunc(val, key) then
			num = num + 1
		end
	end

	return num
end

function table.allmatch(myTable, checkFunc)
	for key, val in pairs(myTable) do
		if not checkFunc(val, key) then
			return false
		end
	end

	return true
end


function table.anymatch(myTable, checkFunc)
	for key, val in pairs(myTable) do
		if checkFunc(val, key) then
			return true
		end
	end

	return false
end


function table.nonematch(myTable, checkFunc)
	for key, val in pairs(myTable) do
		if checkFunc(val, key) then
			return false
		end
	end

	return true
end




