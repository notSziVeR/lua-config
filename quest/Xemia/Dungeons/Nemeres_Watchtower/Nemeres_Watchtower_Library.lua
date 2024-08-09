Nemeres_Watchtower_Library = {};

Nemeres_Watchtower_Library.ReturnData = function()
	if (Nemeres_Watchtower_Library.Data == nil) then
		Nemeres_Watchtower_Library.Data = {
			["TeleportData"] = {
				["InsideDungeon"] = {["InsideMapIndex"] = 352, ["EnterPositions"] = {["x"] = 5291, ["y"] = 1803}},
				["OutsideDungeon"] = {["InsideMapIndex"] = 61, ["EnterPositions"] = {["x"] = 4327, ["y"] = 1667}},
			},

			["LevelRequire"] = {["IsRequire"] = true, ["MinimumLevel"] = 95, ["MaximumLevel"] = 115},
			["GroupRequire"] = {["IsRequire"] = true, ["MinimumPartyMemebers"] = 1, ["MaximumPartyMemebers"] = 2},
			["ItemRequire"] = {["IsRequire"] = true, ["ItemVnum"] = 176005, ["ItemCount"] = 1},

			["TimeData"] = {
				["TimeToCompleteData"] = {["IsRequire"] = true, ["TimeToComplete"] = time_min_to_sec(60)},
				["TimeToWaitData"] = {["IsRequire"] = true, ["TimeToWait"] = time_min_to_sec(90), ["WaitingString"] = "Nemeres_Watchtower"},
			},

			["1st_Teleport_Coords"] = {["x"] = 5541, ["y"] = 1795},
			["2nd_Teleport_Coords"] = {["x"] = 5881, ["y"] = 1806},
			["3rd_Teleport_Coords"] = {["x"] = 5293, ["y"] = 2061},
			["4th_Teleport_Coords"] = {["x"] = 5540, ["y"] = 2064},
			["5th_Teleport_Coords"] = {["x"] = 5866, ["y"] = 2070},
			["6th_Teleport_Coords"] = {["x"] = 5423, ["y"] = 2246},
			["7th_Teleport_Coords"] = {["x"] = 5691, ["y"] = 2242},
			["8th_Teleport_Coords"] = {["x"] = 5968, ["y"] = 2229},
			["9th_Teleport_Coords"] = {["x"] = 6047, ["y"] = 1927},

			["Frost_Key_Vnum"] = 30331,
			["Frost_Key_Count"] = 1,
			["Frost_Key_Math_Random"] = 100,
			["Frost_Key_Chance"] = 1,

			["North_Star_Key_Vnum"] = 30332,
			["North_Star_Key_Count"] = 1,
			["North_Star_Key_Math_Random"] = 75,
			["North_Star_Key_Chance"] = 1,

			["Frostflower_Key_Vnum"] = 30333,
			["Frostflower_Key_Count"] = 1,
			["Frostflower_Key_Math_Random"] = 100,
			["Frostflower_Key_Chance"] = 1,
		};
	end -- if

	return Nemeres_Watchtower_Library.Data;
end -- function

Nemeres_Watchtower_Library.IsInDungeon = function()
	local Data = Nemeres_Watchtower_Library.ReturnData();
	local PlayerMapIndex = pc.get_map_index();
	local DungeonMapIndex = Data["TeleportData"]["InsideDungeon"]["InsideMapIndex"];

	return (pc.in_dungeon() and (PlayerMapIndex >= DungeonMapIndex * 10000) and (PlayerMapIndex < (DungeonMapIndex + 1) * 10000));
end -- function

Nemeres_Watchtower_Library.GetDungeonStage = function()
	local DungeonFlag = d.getf("Nemeres_Watchtower_Stage");

	return DungeonFlag;
end -- function

Nemeres_Watchtower_Library.SetNewDungeonStage = function()
	local DungeonState = Nemeres_Watchtower_Library.GetDungeonStage();

	return (d.setf("Nemeres_Watchtower_Stage", DungeonState + 1));
end -- function

Nemeres_Watchtower_Library.SetWaitTime = function()
	local Data = Nemeres_Watchtower_Library.ReturnData();
	local PlayerPID = pc.get_player_id();
	local TimeData = Data["TimeData"]["TimeToWaitData"];

	local TimeToWaitData = TimeData["TimeToWait"];

	if (TimeData["IsRequire"]) then
		local StrFlagTime = string.format("%s_%d", TimeData["WaitingString"], PlayerPID);

		return game.set_event_flag(StrFlagTime, get_time() + TimeToWaitData);
	end -- if
end -- function

Nemeres_Watchtower_Library.CheckRequire = function()
	local Data = Nemeres_Watchtower_Library.ReturnData();
	local LevelRequire = Data["LevelRequire"];
	local GroupRequire = Data["GroupRequire"];
	local RequireItem = Data["ItemRequire"];
	local TimeData = Data["TimeData"]["TimeToWaitData"];

	local RequireArray = {["MinLevel"] = {{}, true}, ["MaxLevel"] = {{}, true}, ["MaxParty"] = {{}, true}, ["ItemRequire"] = {{}, true}, ["TimeRequire"] = {{}, true}};
	local IsPartyCheck = false;
	if (Data["GroupRequire"]["IsRequire"] and party.is_party()) then
		local PartyGroupIDS = Party_Get_Member_PIDs();

		if (not party.is_leader()) then
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say_reward("You are not the leader of the group. Let me talk with him.")
			say("")
			return false;
		end -- if

		if (party.get_near_count() > GroupRequire["MaximumPartyMemebers"]) then
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say_reward(string.format("Must be in a group of at least %d players.", GroupRequire["MaximumPartyMemebers"]))
			say("")
			return false;
		end -- if

		for index, Value in ipairs(PartyGroupIDS) do
			q.begin_other_pc_block(Value);
			if ((pc.get_level() < LevelRequire["MinimumLevel"]) and LevelRequire["IsRequire"]) then
				table.insert(RequireArray["MinLevel"][1], pc.get_name());
				RequireArray["MinLevel"][2] = false;
			end -- if

			if ((pc.get_level() > LevelRequire["MaximumLevel"]) and LevelRequire["IsRequire"]) then
				table.insert(RequireArray["MaxLevel"][1], pc.get_name());
				RequireArray["MaxLevel"][2] = false;
			end -- if

			if ((pc.count_item(RequireItem["ItemVnum"]) < RequireItem["ItemCount"]) and RequireItem["IsRequire"]) then
				table.insert(RequireArray["ItemRequire"][1], pc.get_name());
				RequireArray["ItemRequire"][2] = false;
			end -- if

			local StrFlagTime = string.format("%s_%d", TimeData["WaitingString"], Value);
			local FlagValue = game.get_event_flag(StrFlagTime);
			local LocalTime = get_time();

			if ((FlagValue > LocalTime) and TimeData["IsRequire"]) then
				table.insert(RequireArray["TimeRequire"][1], string.format("%s - %s", pc.get_name(), Get_Time_Format(FlagValue - LocalTime)));
				RequireArray["TimeRequire"][2] = false;
			end -- if
			q.end_other_pc_block();
		end IsPartyCheck = true; -- for
	end -- if

	if (not IsPartyCheck) then
		if ((pc.get_level() < LevelRequire["MinimumLevel"]) and LevelRequire["IsRequire"]) then
			table.insert(RequireArray["MinLevel"][1], pc.get_name());
			RequireArray["MinLevel"][2] = false;
		end -- if

		if ((pc.get_level() > LevelRequire["MaximumLevel"]) and LevelRequire["IsRequire"]) then
			table.insert(RequireArray["MaxLevel"][1], pc.get_name());
			RequireArray["MaxLevel"][2] = false;
		end -- if

		if (party.get_near_count() > GroupRequire["MaximumPartyMemebers"]) then
			RequireArray["MaxParty"][2] = false;
		end -- if

		if ((pc.count_item(RequireItem["ItemVnum"]) < RequireItem["ItemCount"]) and RequireItem["IsRequire"]) then
			table.insert(RequireArray["ItemRequire"][1], pc.get_name());
			RequireArray["ItemRequire"][2] = false;
		end -- if

		local PlayerPID = pc.get_player_id();
		local StrFlagTime = string.format("%s_%d", TimeData["WaitingString"], PlayerPID);
		local FlagValue = game.get_event_flag(StrFlagTime);
		local LocalTime = get_time();

		if ((FlagValue > LocalTime) and TimeData["IsRequire"]) then
			table.insert(RequireArray["TimeRequire"][1], string.format("%s - %s", pc.get_name(), Get_Time_Format(FlagValue - LocalTime)));
			RequireArray["TimeRequire"][2] = false;
		end -- if
	end -- if

	if (not RequireArray["MinLevel"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("To enter the dungeon the minimum level is %d.", LevelRequire["MinimumLevel"]))
		for index in RequireArray["MinLevel"][1] do
			say_reward(string.format("- %s", RequireArray["MinLevel"][1][index]));
		end -- for
		say("")
		return false;
	end -- if

	if (not RequireArray["MaxLevel"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("To enter the dungeon the maximum level is %d.", LevelRequire["MinimumLevel"]))
		for index in RequireArray["MaxLevel"][1] do
			say_reward(string.format("- %s", RequireArray["MaxLevel"][1][index]));
		end -- for
		say("")
		return false;
	end -- if

	if (not RequireArray["MaxParty"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say_reward("You do not meet the party criteria:")
		say("")
		say(string.format("The maximum number of players in party is %d.", GroupRequire["MaximumPartyMemebers"]))
		say("")
		return false;
	end -- if

	if (not RequireArray["ItemRequire"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("To enter the dungeon, you must own: %dx - %s.", RequireItem["ItemCount"], item_name(RequireItem["ItemVnum"])))
		for index in RequireArray["ItemRequire"][1] do
			say_reward(string.format("- %s", RequireArray["ItemRequire"][1][index]));
		end -- for
		say("")
		return false;
	end -- if

	if (not RequireArray["TimeRequire"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("To enter the dungeon the waiting time is: %s.", Get_Time_Format(TimeData["TimeToWait"])))
		for index in RequireArray["TimeRequire"][1] do
			say_reward(string.format("- %s", RequireArray["TimeRequire"][1][index]));
		end -- for
		say("")
		return false;
	end return true; -- if
end -- function

Nemeres_Watchtower_Library.WarpToDungeon = function()
	local Data = Nemeres_Watchtower_Library.ReturnData();
	local EnterData = Data["TeleportData"]["InsideDungeon"];
	local RequireItem = Data["ItemRequire"];

	if (Data["GroupRequire"]["IsRequire"] and party.is_party()) then
		if (RequireItem["IsRequire"]) then
			local PartyGroupIDS = Party_Get_Member_PIDs();
			for index, Value in ipairs(PartyGroupIDS) do
				q.begin_other_pc_block(Value);
				pc.remove_item(RequireItem["ItemVnum"], RequireItem["ItemCount"]);
				q.end_other_pc_block();
			end -- for
		end -- if

		return d.join(EnterData["InsideMapIndex"]);
	end -- if

	if (not party.is_party()) then
		if (RequireItem["IsRequire"]) then
			pc.remove_item(RequireItem["ItemVnum"], RequireItem["ItemCount"]);
		end -- if

		return d.join(EnterData["InsideMapIndex"]);
	end -- if
end -- function
