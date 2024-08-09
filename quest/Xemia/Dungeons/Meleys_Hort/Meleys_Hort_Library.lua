Meleys_Hort_Library = {};

Meleys_Hort_Library.ReturnData = function()
	if (Meleys_Hort_Library.Data == nil) then
		Meleys_Hort_Library.Data = {
			["TeleportData"] = {
				["InsideDungeon"] = {["InsideMapIndex"] = 320, ["EnterPositions"] = {["x"] = 7824, ["y"] = 15021}},
				["OutsideDungeon"] = {["InsideMapIndex"] = 62, ["EnterPositions"] = {["x"] = 6138, ["y"] = 7070}},
			},

			["LevelRequire"] = {["IsRequire"] = true, ["MinimumLevel"] = 120, ["MaximumLevel"] = 120},
			["GroupRequire"] = {["IsRequire"] = true, ["MinimumPartyMemebers"] = 1, ["MaximumPartyMemebers"] = 2},
			["ItemRequire"] = {["IsRequire"] = true, ["ItemVnum"] = 176007, ["ItemCount"] = 1},

			["TimeData"] = {
				["TimeToCompleteData"] = {["IsRequire"] = true, ["TimeToComplete"] = time_min_to_sec(60)},
				["TimeToWaitData"] = {["IsRequire"] = true, ["TimeToWait"] = time_min_to_sec(60), ["WaitingString"] = "Meleys_Hort"}
			},
		};
	end -- if

	return Meleys_Hort_Library.Data;
end -- function

Meleys_Hort_Library.IsInDungeon = function()
	local Data = Meleys_Hort_Library.ReturnData();
	local PlayerMapIndex = pc.get_map_index();
	local DungeonMapIndex = Data["TeleportData"]["InsideDungeon"]["InsideMapIndex"];

	return (pc.in_dungeon() and (PlayerMapIndex >= DungeonMapIndex * 10000) and (PlayerMapIndex < (DungeonMapIndex + 1) * 10000));
end -- function

Meleys_Hort_Library.GetDungeonStage = function()
	local DungeonFlag = d.getf("Meleys_Hort_Stage");

	return DungeonFlag;
end -- function

Meleys_Hort_Library.SetNewDungeonStage = function()
	local DungeonState = Meleys_Hort_Library.GetDungeonStage();

	return (d.setf("Meleys_Hort_Stage", DungeonState + 1));
end -- function

Meleys_Hort_Library.SetWaitTime = function()
	local Data = Meleys_Hort_Library.ReturnData();
	local PlayerPID = pc.get_player_id();
	local TimeData = Data["TimeData"]["TimeToWaitData"];

	local TimeToWaitData = TimeData["TimeToWait"];

	if (TimeData["IsRequire"]) then
		local StrFlagTime = string.format("%s_%d", TimeData["WaitingString"], PlayerPID);

		return game.set_event_flag(StrFlagTime, get_time() + TimeToWaitData);
	end -- if
end -- function

Meleys_Hort_Library.CheckRequire = function()
	local Data = Meleys_Hort_Library.ReturnData();
	local LevelRequire = Data["LevelRequire"];
	local GroupRequire = Data["GroupRequire"];
	local RequireItem = Data["ItemRequire"];
	local TimeData = Data["TimeData"]["TimeToWaitData"];

	local RequireArray = {["MinLevel"] = {{}, true}, ["MaxLevel"] = {{}, true}, ["MaxParty"] = {{}, true}, ["ItemRequire"] = {{}, true}, ["TimeRequire"] = {{}, true}};
	local IsPartyCheck = false;
	if (Data["GroupRequire"]["IsRequire"] and party.is_party()) then
		local PartyGroupIds = party_get_member_pids();

		if (not party.is_leader()) then
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say_reward("Nie jesteœ liderem grupy. Pozwól mi z nim porozmawiaæ.")
			say("")
			return false;
		end -- if

		if (party.get_near_count() > GroupRequire["MaximumPartyMemebers"]) then
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say_reward(string.format("Musi byæ w grupie co najmniej %d graczy.", GroupRequire["MaximumPartyMemebers"]))
			say("")
			return false;
		end -- if

		for index, value in ipairs(PartyGroupIds) do
			q.begin_other_pc_block(value);
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
					table.insert(RequireArray["TimeRequire"][1], string.format("%s - %s", pc.get_name(), get_time_format(FlagValue - LocalTime)));
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
			table.insert(RequireArray["TimeRequire"][1], string.format("%s - %s", pc.get_name(), get_time_format(FlagValue - LocalTime)));
			RequireArray["TimeRequire"][2] = false;
		end -- if
	end -- if

	if (not RequireArray["MinLevel"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("Aby wejœæ do dungeonu, wymagany minimalny poziom to %d.", LevelRequire["MinimumLevel"]))
		for index in RequireArray["MinLevel"][1] do
			say_reward(string.format("- %s", RequireArray["MinLevel"][1][index]));
			say("")
		end return false;
	end -- if

	if (not RequireArray["MaxLevel"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("Aby wejœæ do dungeonu, wymagany maksymalny poziom to %d.", LevelRequire["MaximumLevel"]))
		for index in RequireArray["MaxLevel"][1] do
			say_reward(string.format("- %s", RequireArray["MaxLevel"][1][index]));
			say("")
		end return false; -- for
	end -- if

	if (not RequireArray["MaxParty"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say_reward("Nie spe³niasz kryteriów przyjêcia:")
		say("")
		say(string.format("Maksymalna liczba graczy w grupie to |cFF009900%d|r.", GroupRequire["MaximumPartyMemebers"]))
		say("")
	end -- if

	if (not RequireArray["ItemRequire"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("Aby wejœæ do dungeonu, musisz posiadaæ: %d - %s.", RequireItem["ItemCount"], item_name(RequireItem["ItemVnum"])))
		for index in RequireArray["ItemRequire"][1] do
			say_reward(string.format("- %s", RequireArray["ItemRequire"][1][index]));
			say("")
		end return false; -- for
	end -- if

	if (not RequireArray["TimeRequire"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say(string.format("Aby wejœæ do dungeonu, czas oczekiwania wynosi: %s", get_time_format(TimeData["TimeToWait"])))
		for index in RequireArray["TimeRequire"][1] do
			say_reward(string.format("- %s", RequireArray["TimeRequire"][1][index]));
			say("")
		end return false; -- for
	end return true; -- if
end -- function

Meleys_Hort_Library.WarpToDungeon = function()
	local Data = Meleys_Hort_Library.ReturnData();
	local EnterData = Data["TeleportData"]["InsideDungeon"];
	local RequireItem = Data["ItemRequire"];

	if (Data["GroupRequire"]["IsRequire"] and party.is_party()) then
		if (RequireItem["IsRequire"]) then
			local partyGroupIds = party_get_member_pids();
			for index, value in ipairs(partyGroupIds) do
				q.begin_other_pc_block(value);
				pc.remove_item(RequireItem["ItemVnum"], RequireItem["ItemCount"]);
				q.end_other_pc_block();
			end -- for
		end -- if

		return sdd.join(320);
	end -- if

	if (not party.is_party()) then
		if (RequireItem["IsRequire"]) then
			pc.remove_item(RequireItem["ItemVnum"], RequireItem["ItemCount"]);
		end -- if

		return sdd.join(320);
	end -- if
end -- function
