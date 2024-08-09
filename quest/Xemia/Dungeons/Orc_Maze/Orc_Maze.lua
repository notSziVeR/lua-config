quest Orc_Maze begin
	state start begin
		when 62001.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when 62001.chat."(Lv. 30) Orc Maze" begin
			local Data = Orc_Maze_Library.ReturnData();
			local LevelRequire = Data["LevelRequire"];
			local GroupRequire = Data["GroupRequire"];
			local ItemRequire = Data["ItemRequire"];

			if (party.is_party() and not party.is_leader()) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say_reward("You are not a group leader. Let me talk to him.")
				say("")
				return;
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say_reward("Welcome to the entrance to the Orc Maze.")
			say("")
			say("Entry Possible: |cFF009900Solo|r/|cFF009900Party")
			if (pc.get_level() < LevelRequire["MinimumLevel"]) then
				say(string.format("Minimum Level: |cFFFF0000%d", LevelRequire["MinimumLevel"]))
			else
				say(string.format("Minimum Level: |cFF009900%d", LevelRequire["MinimumLevel"]))
			end -- if
			if (pc.get_level() > LevelRequire["MaximumLevel"]) then
				say(string.format("Maximum Level: |cFFFF0000%d", LevelRequire["MaximumLevel"]))
			else
				say(string.format("Maximum Level: |cFF009900%d", LevelRequire["MaximumLevel"]))
			end -- if
			if pc.countitem(ItemRequire["ItemVnum"]) >= 1 then
				say(string.format("Pass: " .. item_name(ItemRequire["ItemVnum"]) .. " (|cFF009900%d|r/|cFF009900%d|r)", ItemRequire["ItemCount"], pc.countitem(ItemRequire["ItemVnum"])))
			else
				say(string.format("Pass: " .. item_name(ItemRequire["ItemVnum"]) .. " (|cFF009900%d|r/|cFFFF0000%d|r)", ItemRequire["ItemCount"], pc.countitem(ItemRequire["ItemVnum"])))
			end -- if
			if (party.is_party() and party.is_leader()) then
				say_oldwoman("(Everyone in the group needs a pass in their inventory)")
			end -- if
			if (party.is_party() and party.is_leader()) then
				if (party.get_near_count() >= 3) then
					say(string.format("Group: (|cFF009900%d|r/|cFFFF0000%d|r)", GroupRequire["MaximumPartyMemebers"], party.get_near_count()))
				else
					if (party.get_near_count() < 1) then
						say(string.format("Group: (|cFF009900%d|r/|cFFFF0000%d|r)", GroupRequire["MaximumPartyMemebers"], party.get_near_count()))
					else
						say(string.format("Group: (|cFF009900%d|r/|cFF009900%d|r)", GroupRequire["MaximumPartyMemebers"], party.get_near_count()))
					end -- if
				end -- if
			else
				say("Group: |cFF009900You don't have a Group")
			end -- if
			say("")
			say_reward("Do you want to enter the Orc Maze?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Orc_Maze_Library.CheckRequire()) then
					Orc_Maze_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 62001.chat."(Lv. 30) Orc Maze - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return;
			end -- if
		end -- when

		when login with (Orc_Maze_Library.IsInDungeon()) begin
			local Data = Orc_Maze_Library.ReturnData();
			local Lv = Orc_Maze_Library.GetDungeonStage();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (TimeData["IsRequire"]) then
				clear_server_timer("Orc_Maze_Time_Out", get_server_timer_arg());
				server_timer("Orc_Maze_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			Dungeon_Task_Helper.RegisterListener();

			if (Lv == 0) then
				Orc_Maze_Library.SetWaitTime();
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Orc_Maze.Prepare(1);
				Dungeon_Task_Helper.ClearGlobalTimer();
				Dungeon_Task_Helper.SetGlobalTimer();
			end -- if
		end -- when

		when Orc_Maze_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Orc Maze.")
				d.exit_all();
			end -- if
		end -- when

		function Prepare(Stage)
			local Data = Orc_Maze_Library.ReturnData();

			if (Orc_Maze_Library.GetDungeonStage() == Stage) then
				return;
			end -- if

			Orc_Maze_Library.SetNewDungeonStage();

			Dungeon_Task_Helper.PopState();
			Dungeon_Task_Helper.SendStateInfo();

			if is_test_server() or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. Stage .. ".")
			end -- if

			if (1 == Stage) then
				d.notice("Follow the first path, find and destroy correct Orc Labyrinth Metin.")

				local MetinStonePosition = {
					{406, 222}, {418, 214}, {415, 201},
					{403, 199}, {393, 210}, {397, 220}
				};

				for index = 1, table.getn(MetinStonePosition) - 1, 1 do
					local RandomNumber = math.random(table.getn(MetinStonePosition));
					d.spawn_mob(8070, MetinStonePosition[RandomNumber][1], MetinStonePosition[RandomNumber][2]);
					table.remove(MetinStonePosition, RandomNumber);
				end -- for

				local RealMetinStoneVID = d.spawn_mob(8070, MetinStonePosition[1][1], MetinStonePosition[1][2]);
				d.set_unique("Real_Metin_Stone", RealMetinStoneVID);

				d.set_regen_file("data/dungeon/orc_maze/regen_01.txt");

				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (2 == Stage) then
				d.notice("Defeat the monsters until you find the correct Orc Stone Key.")

				d.set_regen_file("data/dungeon/orc_maze/regen_02.txt");

				local FirstStagePos = Data["1st_Teleport_Coords"];
				d.jump_all(FirstStagePos["x"], FirstStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (3 == Stage) then
				d.notice("Defeat the monsters to get the Orc Key. One key can only be used for one seal.")

				d.setf("Ancient_Seal_Count", 5);

				d.set_unique("Ancient_Seal_01", d.spawn_mob(61001, 45, 1395));
				d.set_unique("Ancient_Seal_02", d.spawn_mob(61001, 60, 1395));
				d.set_unique("Ancient_Seal_03", d.spawn_mob(61001, 45, 1370));
				d.set_unique("Ancient_Seal_04", d.spawn_mob(61001, 60, 1370));

				d.set_regen_file("data/dungeon/orc_maze/regen_03.txt");

				local SecondStagePos = Data["2nd_Teleport_Coords"];
				d.jump_all(SecondStagePos["x"], SecondStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(4);
			end -- if

			if (4 == Stage) then
				d.notice("Follow the right path and climb Orc Labyrinth Metin to get the Wood that will help you lure Chief Elite Orc.")

				d.set_regen_file("data/dungeon/orc_maze/regen_04.txt");

				local ThirdStagePos = Data["3rd_Teleport_Coords"];
				d.jump_all(ThirdStagePos["x"], ThirdStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (5 == Stage) then
				d.notice(string.format("Find and defeat Chief Elite Orc.", mob_name(692)))

				d.spawn_mob(692, 119, 499);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (6 == Stage) then
				d.notice("Defeat Reborn Chief Ork.")

				d.spawn_mob(693, 138, 887);

				local FourthStagePos = Data["4th_Teleport_Coords"];
				d.jump_all(FourthStagePos["x"], FourthStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Orc_Maze_Library.IsInDungeon() begin
			local Lv = Orc_Maze_Library.GetDungeonStage();

			if (1 == Lv) then
				if (npc.get_race() == 8070) then
					local NPCVID = npc.get_vid(); local RealMetinStoneVID = d.get_unique_vid("Real_Metin_Stone");
					if (NPCVID == RealMetinStoneVID) then
						d.notice("A valid Orc Labyrinth Metin has been defeated.")
						d.notice("You completed the task. The next task will be in 5 seconds.");
						ClearDungeon(true);
						timer("timer", 5);
						Dungeon_Task_Helper.IncCounter(1);
					else
						d.notice("This Orc Labyrinth Metin is false.")
					end -- if
				end -- if
			end -- if

			if (2 == Lv) then
				local Data = Orc_Maze_Library.ReturnData();

				if (math.random(Data["Orc_Key_Math_Random"]) <= Data["Orc_Key_Chance"]) then
					game.drop_item(Data["Orc_Key_Vnum"], Data["Orc_Key_Count"]);
					ClearDungeon(true);
				end -- if
			end -- if

			if (3 == Lv) then
				local Data = Orc_Maze_Library.ReturnData();

				if (math.random(Data["Orc_Stone_Key_Math_Random"]) <= Data["Orc_Stone_Key_Chance"]) then
					game.drop_item(Data["Orc_Stone_Key_Vnum"], Data["Orc_Stone_Key_Count"]);
				end -- if
			end -- if

			if (4 == Lv) then
				if (npc.get_race() == 8070) then
					local Data = Orc_Maze_Library.ReturnData();

					if (math.random(Data["Wood_Math_Random"]) <= Data["Wood_Chance"]) then
						game.drop_item(Data["Wood_Vnum"], Data["Wood_Count"]);
						ClearDungeon(true);
					end -- if
				end -- if
			end -- if

			if (5 == Lv) then
				if (npc.get_race() == 692) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
				end -- if
			end -- if

			if (6 == Lv) then
				if (npc.get_race() == 693) then
					local Data = Orc_Maze_Library.ReturnData();

					local DungeonTime = get_time() - d.getf("DungeonTime");

					d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
					if party.is_party() then
						notice_all(string.format("The group founded by %s completed dungeon - Orc Maze in %s.", pc.name, Get_Time_Format(DungeonTime)))
					else
						notice_all(string.format("Player %s completed dungeon - Orc Maze in %s.", pc.name, Get_Time_Format(DungeonTime)))
					end -- if

					timer("ExitDung", 30);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
					d.finish();
				end -- if
			end -- if
		end -- when

		when 29511.use with (Orc_Maze_Library.IsInDungeon() and Orc_Maze_Library.GetDungeonStage() == 2) begin
			d.notice("You completed the task. The next task will be in 5 seconds.");
			local DeleteItem = {29511};
			for index in DeleteItem do
				if (pc.count_item(DeleteItem[index]) > 0) then
					pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
				end -- if
			end -- for
			timer("timer", 5);
			ClearDungeon(true);
			Dungeon_Task_Helper.IncCounter(1);
		end -- when

		when 61001.take or 61001.click or 29512.use with (Orc_Maze_Library.IsInDungeon() and Orc_Maze_Library.GetDungeonStage() == 3) begin
			if item.vnum == 29512 then
				d.setf("Ancient_Seal_Count", d.getf("Ancient_Seal_Count") - 1);

				local DeleteItem = {29512};
				for index in DeleteItem do
					pc.remove_item(DeleteItem[index], 1);
				end -- for

				Dungeon_Task_Helper.IncCounter(1);

				if d.getf("Ancient_Seal_Count") == 4 then
					d.notice("The seal has been opened. Left: " .. (d.getf("Ancient_Seal_Count") - 1) .. ".")
					d.purge_unique("Ancient_Seal_01");
				elseif d.getf("Ancient_Seal_Count") == 3 then
					d.notice("The seal has been opened. Left: " .. (d.getf("Ancient_Seal_Count") - 1) .. ".")
					d.purge_unique("Ancient_Seal_02");
				elseif d.getf("Ancient_Seal_Count") == 2 then
					d.notice("The seal has been opened. Left: " .. (d.getf("Ancient_Seal_Count") - 1) .. ".")
					d.purge_unique("Ancient_Seal_03");
				elseif d.getf("Ancient_Seal_Count") == 1 then
					d.setf("Ancient_Seal_Count", 0);
					d.purge_unique("Ancient_Seal_04");
					d.notice("All the seals have been opened.")
					d.notice("You completed the task. The next task will be in 5 seconds.");
					local DeleteItem = {29512};
					for index in DeleteItem do
						if (pc.count_item(DeleteItem[index]) > 0) then
							pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
						end -- if
					end -- for
					timer("timer", 5);
					ClearDungeon(true);
				end -- if
			end -- if
		end -- when

		when 29513.use with (Orc_Maze_Library.IsInDungeon() and Orc_Maze_Library.GetDungeonStage() == 4) begin
			local DeleteItem = {29513};
			for index in DeleteItem do
				if (pc.count_item(DeleteItem[index]) > 0) then
					pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
				end -- if
			end -- for
			timer("timer", 5);
			d.notice("You completed the task. The next task will be in 5 seconds.");
			ClearDungeon(true);
			Dungeon_Task_Helper.IncCounter(1);
		end -- when

		when ExitDung.timer with Orc_Maze_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Orc Maze.")
			d.exit_all();
		end -- when

		when timer.timer with Orc_Maze_Library.IsInDungeon() begin
			local Lv = Orc_Maze_Library.GetDungeonStage();

			if Lv == 1 then
				Orc_Maze.Prepare(2);
			end -- if

			if Lv == 2 then
				Orc_Maze.Prepare(3);
			end -- if

			if Lv == 3 then
				Orc_Maze.Prepare(4);
			end -- if

			if Lv == 4 then
				Orc_Maze.Prepare(5);
			end -- if

			if Lv == 5 then
				Orc_Maze.Prepare(6);
			end -- if
		end -- when
	end -- state
end -- quest
