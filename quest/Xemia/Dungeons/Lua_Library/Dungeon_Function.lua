DungeonData = {};

ClearDungeon = function(RevivedBoolean)
	if (pc.in_dungeon()) then
		d.clear_regen();
		d.kill_all();

		if (RevivedBoolean) then
			d.kill_all();
		end -- if
	end -- if
end -- function

IsDungeonNPCBlocked = function()
	local MapIndex = pc.get_map_index();

	for index in DungeonData do
		if (DungeonData[index][1] == MapIndex) then
			return true;
		end -- if
	end return false; -- for
end -- function

BlockDungeonNPC = function()
	local PlayerName = pc.get_name(); local MapIndex = pc.get_map_index();
	return table.insert(DungeonData, {MapIndex, PlayerName});
end -- function

Party_Get_Member_PIDs = function()
	local PIDs = {party.get_member_pids()}; 

	return PIDs;
end -- function

Get_Time_Format = function(Sec)
	local Sec = tonumber(Sec);
	local Final_String = "";
	local String_Type = "";

	local Epoch = {["Hour"] = 1, ["Day"] = 1, ["Month"] = 1, ["Year"] = 1970};
	local Time_Formats = {
		{["Date"] = tonumber(os.date('%S', Sec)),					["Plural"] = "seconds",		["Singular"] = "second"},
		{["Date"] = tonumber(os.date('%M', Sec)),					["Plural"] = "minutes",		["Singular"] = "minute"},
		{["Date"] = tonumber(os.date('%H', Sec)) - Epoch["Hour"],	["Plural"] = "hours",		["Singular"] = "hour"},
		{["Date"] = tonumber(os.date('%d', Sec)) - Epoch["Day"],	["Plural"] = "days",		["Singular"] = "day"},
		{["Date"] = tonumber(os.date('%m', Sec)) - Epoch["Month"],	["Plural"] = "months",		["Singular"] = "month"},
		{["Date"] = tonumber(os.date('%Y', Sec)) - Epoch["Year"],	["Plural"] = "years",		["Singular"] = "year"}
	};

	for Strings, Data in Time_Formats do
		if (Data["Date"] > 0) then
			if (Strings > 1) then
				Final_String = string.format(" %s", Final_String);
			end -- if

			if (Data["Date"] > 1) then
				String_Type = Data["Plural"];
			else
				String_Type = Data["Singular"];
			end -- if

			Final_String = string.format("%d %s%s", Data["Date"], String_Type, Final_String);
		end -- if
	end -- for

	return Final_String;
end -- function
