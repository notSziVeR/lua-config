Demon_Tower_Library = {};

Demon_Tower_Library.ReturnData = function()
	if (Demon_Tower_Library.Data == nil) then
		Demon_Tower_Library.Data = {
			["TeleportData"] = {
				["InsideDungeon"] = {["InsideMapIndex"] = 66, ["EnterPositions"] = {["x"] = 2165, ["y"] = 7270}},
				["OutsideDungeon"] = {["InsideMapIndex"] = 65, ["EnterPositions"] = {["x"] = 5903, ["y"] = 1110}},
			},

			["LevelRequire"] = {["IsRequire"] = true, ["MinimumLevel"] = 40, ["MaximumLevel"] = 115},
			["GroupRequire"] = {["IsRequire"] = true, ["MinimumPartyMemebers"] = 1, ["MaximumPartyMemebers"] = 2},
			["GoldRequire"] = {["IsRequire"] = true, ["GoldCount"] = 1000000},

			["TimeData"] = {
				["TimeToCompleteData"] = {["IsRequire"] = true, ["TimeToComplete"] = time_min_to_sec(60)},
			},

			["1st_Teleport_Coords"] = {["x"] = 2182, ["y"] = 6803},
			["2nd_Teleport_Coords"] = {["x"] = 2417, ["y"] = 7285},
			["3rd_Teleport_Coords"] = {["x"] = 2417, ["y"] = 7057},
			["4th_Teleport_Coords"] = {["x"] = 2422, ["y"] = 6823},
			["5th_Teleport_Coords"] = {["x"] = 2638, ["y"] = 7294},
			["6th_Teleport_Coords"] = {["x"] = 2638, ["y"] = 7059},
			["7th_Teleport_Coords"] = {["x"] = 2638, ["y"] = 6811},

			["Key_Stone_Vnum"] = 50084,
			["Key_Stone_Count"] = 1,
			["Key_Stone_Math_Random"] = 100,
			["Key_Stone_Chance"] = 1,

			["Allowed_Refines"] = 1,
			["Blacksmiths"] = {20074, 20075, 20076},

			["Zin_Sa_Gui_Tower_Map_Vnum"] = 30302,
			["Zin_Sa_Gui_Tower_Map_Count"] = 1,
			["Zin_Sa_Gui_Tower_Map_Math_Random"] = 100,
			["Zin_Sa_Gui_Tower_Map_Chance"] = 50,

			["Zin_Bong_In_Key_Vnum"] = 30304,
			["Zin_Bong_In_Key_Count"] = 1,
			["Zin_Bong_In_Key_Math_Random"] = 100,
			["Zin_Bong_In_Key_Chance"] = 5,
		};
	end -- if

	return Demon_Tower_Library.Data;
end -- function

Demon_Tower_Library.IsInDungeon = function()
	local Data = Demon_Tower_Library.ReturnData();
	local PlayerMapIndex = pc.get_map_index();
	local DungeonMapIndex = Data["TeleportData"]["InsideDungeon"]["InsideMapIndex"];

	return (pc.in_dungeon() and (PlayerMapIndex >= DungeonMapIndex * 10000) and (PlayerMapIndex < (DungeonMapIndex + 1) * 10000));
end -- function

Demon_Tower_Library.GetDungeonStage = function()
	local DungeonFlag = d.getf("Demon_Tower_Stage");

	return DungeonFlag;
end -- function

Demon_Tower_Library.SetNewDungeonStage = function()
	local DungeonState = Demon_Tower_Library.GetDungeonStage();

	return (d.setf("Demon_Tower_Stage", DungeonState + 1));
end -- function

Demon_Tower_Library.CheckRequire = function()
	local Data = Demon_Tower_Library.ReturnData();
	local LevelRequire = Data["LevelRequire"];
	local GroupRequire = Data["GroupRequire"];
	local GoldRequire = Data["GoldRequire"];

	local RequireArray = {["MinLevel"] = {{}, true}, ["MaxLevel"] = {{}, true}, ["MaxParty"] = {{}, true}, ["GoldRequire"] = {{}, true}};
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

			if ((pc.money < GoldRequire["GoldCount"]) and GoldRequire["IsRequire"]) then
				table.insert(RequireArray["GoldRequire"][1], pc.get_name());
				RequireArray["GoldRequire"][2] = false;
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

		if ((pc.money < GoldRequire["GoldCount"]) and GoldRequire["IsRequire"]) then
			table.insert(RequireArray["GoldRequire"][1], pc.get_name());
			RequireArray["GoldRequire"][2] = false;
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
	end

	if (not RequireArray["GoldRequire"][2]) then
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
		say("To enter the dungeon, you must own: 1.000.000 Yang.")
		for index in RequireArray["GoldRequire"][1] do
			say_reward(string.format("- %s", RequireArray["GoldRequire"][1][index]));
		end -- for
		say("")
		return false;
	end return true; -- if
end -- function

Demon_Tower_Library.WarpToDungeon = function()
	local Data = Demon_Tower_Library.ReturnData();
	local EnterData = Data["TeleportData"]["InsideDungeon"];
	local GoldRequire = Data["GoldRequire"];

	if (Data["GroupRequire"]["IsRequire"] and party.is_party()) then
		if (GoldRequire["IsRequire"]) then
			local PartyGroupIDS = Party_Get_Member_PIDs();
			for index, Value in ipairs(PartyGroupIDS) do
				q.begin_other_pc_block(Value);
				pc.changegold(-GoldRequire["GoldCount"])
				q.end_other_pc_block();
			end -- for
		end -- if

		return d.join(EnterData["InsideMapIndex"]);
	end -- if

	if (not party.is_party()) then
		if (GoldRequire["IsRequire"]) then
			pc.changegold(-GoldRequire["GoldCount"])
		end -- if

		return d.join(EnterData["InsideMapIndex"]);
	end -- if
end -- function
