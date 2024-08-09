Devils_Catacomb_Library = {};

Devils_Catacomb_Library.ReturnData = function()
	if (Devils_Catacomb_Library.Data == nil) then
		Devils_Catacomb_Library.Data = {
			["TeleportData"] = {
				["InsideDungeon"] = {["InsideMapIndex"] = 216, ["EnterPositions"] = {["x"] = 3149, ["y"] = 12085}},
				["OutsideDungeon"] = {["InsideMapIndex"] = 65, ["EnterPositions"] = {["x"] = 5910, ["y"] = 989}},
			},

			["LevelRequire"] = {["IsRequire"] = true, ["MinimumLevel"] = 75, ["MaximumLevel"] = 120},
			["GroupRequire"] = {["IsRequire"] = true, ["MinimumPartyMemebers"] = 1, ["MaximumPartyMemebers"] = 2},
			["ItemRequire"] = {["IsRequire"] = true, ["ItemVnum"] = 176003, ["ItemCount"] = 1},

			["TimeData"] = {
				["TimeToCompleteData"] = {["IsRequire"] = true, ["TimeToComplete"] = time_min_to_sec(60)},
				["TimeToWaitData"] = {["IsRequire"] = true, ["TimeToWait"] = time_min_to_sec(30), ["WaitingString"] = "Devils_Catacomb"},
			},

			["1st_Teleport_Coords"] = {["x"] = 3620, ["y"] = 12077},
			["2nd_Teleport_Coords"] = {["x"] = 4418, ["y"] = 12282},
			["3rd_Teleport_Coords"] = {["x"] = 3572, ["y"] = 12762},
			["4th_Teleport_Coords"] = {["x"] = 3917, ["y"] = 12902},
			["5th_Teleport_Coords"] = {["x"] = 4435, ["y"] = 12737},
			["6th_Teleport_Coords"] = {["x"] = 3146, ["y"] = 13192},
		};
	end -- if

	return Devils_Catacomb_Library.Data;
end -- function

Devils_Catacomb_Library.IsInDungeon = function()
	local Data = Devils_Catacomb_Library.ReturnData();
	local PlayerMapIndex = pc.get_map_index();
	local DungeonMapIndex = Data["TeleportData"]["InsideDungeon"]["InsideMapIndex"];

	return (pc.in_dungeon() and (PlayerMapIndex >= DungeonMapIndex * 10000) and (PlayerMapIndex < (DungeonMapIndex + 1) * 10000));
end -- function

Devils_Catacomb_Library.GetDungeonStage = function()
	local DungeonFlag = d.getf("Devils_Catacomb_Stage");

	return DungeonFlag;
end -- function

Devils_Catacomb_Library.SetNewDungeonStage = function()
	local DungeonState = Devils_Catacomb_Library.GetDungeonStage();

	return (d.setf("Devils_Catacomb_Stage", DungeonState + 1));
end -- function

Devils_Catacomb_Library.SetWaitTime = function()
	local Data = Devils_Catacomb_Library.ReturnData();
	local PlayerPID = pc.get_player_id();
	local TimeData = Data["TimeData"]["TimeToWaitData"];

	local TimeToWaitData = TimeData["TimeToWait"];

	if (TimeData["IsRequire"]) then
		local StrFlagTime = string.format("%s_%d", TimeData["WaitingString"], PlayerPID);

		return game.set_event_flag(StrFlagTime, get_time() + TimeToWaitData);
	end -- if
end -- function

Devils_Catacomb_Library.CheckRequire = function()
	local Data = Devils_Catacomb_Library.ReturnData();
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

			local StrFlagTime = string.format("%s_%d", TimeData["WaitingString"], value);
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

Devils_Catacomb_Library.WarpToDungeon = function()
	local Data = Devils_Catacomb_Library.ReturnData();
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
