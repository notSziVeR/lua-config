function Table_Contains(Tab, Element)
	for k, v in pairs(Tab) do
		if k == Element then
			return true;
		end -- if
	end -- for

	return false;
end -- function

-- Separated struct for feature
Dungeon_Task_Helper = {};

-- Sample data
Dungeon_Task_Helper.Config = {
	[250] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5", "Stage 6"},
		["Description"] = {
			"Follow the first path, find and destroy correct Orc Labyrinth Metin.",
			"Defeat the monsters until you find the correct Orc Stone Key.",
			"Defeat the monsters to get the Orc Key. One key can only be used for one seal.",
			"Follow the right path and climb Orc Labyrinth Metin to get the Wood that will help you lure Chief Elite Orc.",
			"Find and defeat Chief Elite Orc.",
			"Defeat Reborn Chief Ork."
		},
		["Global_Timer"] = 1800
	},
	
	[74] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3"},
		["Description"] = {
			"Destroy 4 Spider Egg.",
			"Defeat Spider Baron to get Arachnids Whistle.",
			"Defeat Spider Baroness."
		},
		["Global_Timer"] = 1200
	},

	[66] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5", "Stage 6", "Stage 7", "Stage 8", "Stage 9", "Stage 10", "Stage 11"},
		["Description"] = {
			"Destroy Metin of Toughness to get to the next stage.",
			"Defeat Demon King.",
			"Defeat Metin of Devil.",
			"Find and destroy the correct Metin of Fall.",
			"Kill monsters to get Key Stone. It will be necessary to open all 5 Ancient Seal.",
			"Defeat Proud Demon King.",
			"The Blacksmith has appeared, you can choose the next way.",
			"Destroy all Metin of Death.",
			"Defeat Metin of Murder to get Zin-Sa-Gui Tower Map.",
			"Drop the Zin-Bong-In Key and place it on Sa-Soe.",
			"Defeat Death Reaper."
		},
		["Global_Timer"] = 1800
	},

	[216] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5", "Stage 6", "Stage 7"},
		["Description"] = {
			"Get Soul Crystal Key from monsters and move to Kud Statue.",
			"Defeat all Gate of Perdition and click on Tortoise Rock.",
			"Find and destroy the correct Metin of Resentment.",
			"Defeat all Metin of Retribution.",
			"Find and destroy the correct Tartaros.",
			"Defeat Charon.",
			"Defeat Azrael."
		},
		["Global_Timer"] = 1800
	},

	[208] = {
		["Title"] = {"Stage 1", "Stage 2"},
		["Description"] = {
			"Defeat enemies to summon 4 Metin Stones and destroy them.",
			"Defeat Beran-Setaou."
		},
		["Global_Timer"] = 1800
	},

	[351] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5", "Stage 6", "Stage 7", "Stage 8"},
		["Description"] = {
			"Udaj siê do %s, aby da³ ci zadania, aby udaæ sie do pokoju %s.",
			"Zabijaj potwory, dopóki nie zdobêdziesz %s.",
			"Zdob¹dŸ i znajdz prawid³owy %s z potworów i otwórz %s.",
			"Zniscz prawid³owego %s, aby otrzymaæ %s.",
			"Pokonaj %s.",
			"Zabij potwory, aby upuœciæ %s, aby odblokowaæ wszystkie 7 %s.",
			"Zniszcz %s.",
			"Pokonaj %s."
		},
		["Global_Timer"] = 1800
	},

	[352] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5", "Stage 6", "Stage 7", "Stage 8", "Stage 9", "Stage 10"},
		["Description"] = {
			"Defeat all monsters.",
			"Defeat the monsters until you find the correct Frost Key.",
			"Defeat all monsters.",
			"Defeat all monsters.",
			"Kill monsters to drop the North Star to unlock all 5 Arctic Cube.",
			"Defeat all monsters.",
			"Find and destroy the correct Szel.",
			"Defeat the monsters until you find the Frostflower Key.",
			"Defeat North Dragon Pillar.",
			"Defeat Nemere."
		},
		["Global_Timer"] = 1800
	},

	[353] = {
		["Title"] = {"Stage 1", "Stage 2"},
		["Description"] = {
			"Defeat Bagjanamu.",
			"Defeat Jotun Thrym."
		},
		["Global_Timer"] = 1800
	},

	[320] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3"},
		["Description"] = {
			"Stage 1",
			"Stage 2",
			"Stage 3"
		},
		["Global_Timer"] = 1800
	},

	[321] = {
		["Title"] = {"Stage 1", "Stage 2", "Stage 3"},
		["Description"] = {
			"Stage 1",
			"Stage 2",
			"Stage 3"
		},
		["Global_Timer"] = 1800
	},
}

-- List of functions
-- RegisterListener -> registers player to dungeon and sends tasks' list
-- PopState -> pops player to next task and send its description
-- SendStateInfo -> sends info to player regarding appropriate state
-- SetMaxCounter -> sets maximal counter value
-- IncCounter -> incremenents counter
-- DecCounter -> decrements counter
-- ClearCounter -> sets counter
-- SetGlobalTimer -> sets global timer
-- ClearGlobalTimer -> clears global timer
-- SetLocalTimer -> sets local timer
-- ClearLocalTimer -> clears local timer

-- CmdChats
-- DungeonTaskHelper_RegisterTask(iNum, sTitle) -> sends task and their titles
-- DungeonTaskHelper_SetGlobalTimer(iDuration) -> sends dungeon's duration
-- DungeonTaskHelper_SetCurrentTask(iNum, sDesc, iCount, iProgress) -> sends dungeon's description, counter (if exists) and task's progress
-- DungeonTaskHelper_EndTasks() -> marks dungeon as done
-- DungeonTaskHelper_SetLocalTimer(iDuration) -> sends task's duration
-- DungeonTaskHelper_UpdateCounter(iCounter) -> updates task's counter
-- DungeonTaskHelper_UpdateProgress(iProgress) -> updates task's progress

-- Function name to match debug pattern
function __FUNC_NAME__()
	return debug.getinfo(2, 'n').name;
end -- function

-- Checkup function
Dungeon_Task_Helper.CheckInvariants = function()
	local iRealMapIndex = math.floor(d.get_map_index() / 10000);
	if not Table_Contains(Dungeon_Task_Helper.Config, iRealMapIndex) then
		sys_err(string.format("%s Map %d is not a dungeon map!", __FUNC_NAME__(), pc.get_map_index()));
		return false;
	end -- if

	return true;
end -- function

-- Functor applier
Dungeon_Task_Helper.ApplyFunction = function(func)
	for k, v in pairs(d.get_dungeon_pids()) do
		q.begin_other_pc_block(v);
		func();
		q.end_other_pc_block();
	end -- for
end -- function

-- Updater
Dungeon_Task_Helper.UpdateState = function(sType)
	if sType == "Counter" then
		Dungeon_Task_Helper.ApplyFunction(function() cmdchat(string.format("DungeonTaskHelper_UpdateCounter %d", d.getf("Counter"))); end) -- function
		Dungeon_Task_Helper.ApplyFunction(function() cmdchat(string.format("DungeonTaskHelper_UpdateProgress %d", math.floor(d.getf("Counter") / math.max(1, d.getf("Counter_Bound")) * 100))); end) -- function
	elseif sType == "Global_Timer" then
		Dungeon_Task_Helper.ApplyFunction(function() cmdchat(string.format("DungeonTaskHelper_SetGlobalTimer %d", d.getf("Global_Timer") - get_time())); end) -- function
	elseif sType == "Local_Timer" then
		Dungeon_Task_Helper.ApplyFunction(function() cmdchat(string.format("DungeonTaskHelper_SetLocalTimer %d", d.getf("Local_Timer") - get_time())); end) -- function
	end -- if
end -- function

-- Listener function, should be called for any player that enter dungeon
-- BEWARE: Call it AFTER initial state and global timer are set
Dungeon_Task_Helper.RegisterListener = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	-- Broadcast config
	local iRealMapIndex = math.floor(d.get_map_index() / 10000);
	local tConfig = Dungeon_Task_Helper.Config[iRealMapIndex];

	for k, v in pairs(tConfig["Title"]) do
		cmdchat(string.format("DungeonTaskHelper_RegisterTask %d %s", k, string.gsub(v, " ", "|")));
	end -- for

	-- If global timer exists, broadcast it as well
	if d.getf("Global_Timer") > get_time() then
		cmdchat(string.format("DungeonTaskHelper_SetGlobalTimer %d", d.getf("Global_Timer") - get_time()));
	end -- if

	-- Check send task info
	if d.getf("Info_State") > 0 then
		Dungeon_Task_Helper.SendStateInfo(d.getf("Info_State"));
	end -- if
end -- function

-- Move to next state and update existing players
Dungeon_Task_Helper.PopState = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	-- Clear counter
	Dungeon_Task_Helper.ClearCounter();

	-- Reset local timer
	Dungeon_Task_Helper.ClearLocalTimer();

	d.setf("Info_State", d.getf("Info_State") + 1);
	Dungeon_Task_Helper.ApplyFunction(Dungeon_Task_Helper.SendStateInfo);
end -- function

-- Send state info containing: Number, Description, Counter (0 if none is set), Local timer
Dungeon_Task_Helper.SendStateInfo = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	-- Send current state num and desc
	local iState = d.getf("Info_State");
	local iRealMapIndex = math.floor(d.get_map_index() / 10000);
	local tConfig = Dungeon_Task_Helper.Config[iRealMapIndex];

	if iState <= table.getn(tConfig["Title"]) then
		cmdchat(string.format("DungeonTaskHelper_SetCurrentTask %d %s %d %d", iState, string.gsub(tConfig["Description"][iState], " ", "|"), d.getf("Counter"), math.floor(d.getf("Counter") / math.max(1, d.getf("Counter_Bound")) * 100)));
	else
		cmdchat("DungeonTaskHelper_EndTasks");
	end -- if

	-- Send local counter if exists
	if d.getf("Local_Timer") > get_time() then
		cmdchat(string.format("DungeonTaskHelper_SetLocalTimer %d", d.getf("Local_Timer") - get_time()));
	end -- if
end -- function

-- Set max dungeon counter
Dungeon_Task_Helper.SetMaxCounter = function(iMax)
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	d.setf("Counter_Bound", iMax);
	Dungeon_Task_Helper.UpdateState("Counter");
end -- function

-- Increment dungeon counter
Dungeon_Task_Helper.IncCounter = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	d.setf("Counter", d.getf("Counter") + 1);
	Dungeon_Task_Helper.UpdateState("Counter");
end -- function

-- Decrement dungeon counter
Dungeon_Task_Helper.DecCounter = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	d.setf("Counter", d.getf("Counter") - 1);
	Dungeon_Task_Helper.UpdateState("Counter");
end -- function

-- Complete dungeon counter
Dungeon_Task_Helper.CompleteCounter = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	d.setf("Counter", d.getf("Counter_Bound"));
	Dungeon_Task_Helper.UpdateState("Counter");
end -- function

-- Clear counter
Dungeon_Task_Helper.ClearCounter = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	d.setf("Counter", 0);
	Dungeon_Task_Helper.UpdateState("Counter");
end -- function

-- Set global timer
Dungeon_Task_Helper.SetGlobalTimer = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	local iRealMapIndex = math.floor(d.get_map_index() / 10000);
	local tConfig = Dungeon_Task_Helper.Config[iRealMapIndex];

	d.setf("Global_Timer", get_time() + tConfig["Global_Timer"]);
	Dungeon_Task_Helper.UpdateState("Global_Timer");
end -- function

-- Clear global timer
Dungeon_Task_Helper.ClearGlobalTimer = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	d.setf("Global_Timer", 0);
	Dungeon_Task_Helper.UpdateState("Global_Timer");
end -- function

-- Set local timer
Dungeon_Task_Helper.SetLocalTimer = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	local iRealMapIndex = math.floor(d.get_map_index() / 10000);
	local tConfig = Dungeon_Task_Helper.Config[iRealMapIndex];

	if d.getf("Info_State") > 0 and d.getf("Info_State") <= table.getn(tConfig["Local_Timer"]) then
		d.setf("Local_Timer", get_time() + tConfig["Local_Timer"][d.getf("Info_State")]);
		Dungeon_Task_Helper.UpdateState("Local_Timer");
	end -- if
end -- function

-- Clear local timer
Dungeon_Task_Helper.ClearLocalTimer = function()
	-- Check invariants
	if not Dungeon_Task_Helper.CheckInvariants() then
		return;
	end -- if

	d.setf("Local_Timer", 0);
	Dungeon_Task_Helper.UpdateState("Local_Timer");
end -- function
