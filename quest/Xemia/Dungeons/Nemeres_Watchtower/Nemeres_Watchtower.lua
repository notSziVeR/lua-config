quest Nemeres_Watchtower begin
	state start begin
		when 20395.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when 20395.chat."(Lv. 95) Nemere's Watchtower" begin
			local Data = Nemeres_Watchtower_Library.ReturnData();
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
			say_reward("Welcome to the entrance to the (Lv. 95) Nemere's Watchtower.")
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
			say_reward("Do you want to enter the Nemere's Watchtower?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Nemeres_Watchtower_Library.CheckRequire()) then
					Nemeres_Watchtower_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 20395.chat."(Lv. 95) Nemere's Watchtower - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return;
			end -- if
		end -- when

		when login with (Nemeres_Watchtower_Library.IsInDungeon()) begin
			local Data = Nemeres_Watchtower_Library.ReturnData();
			local Lv = Nemeres_Watchtower_Library.GetDungeonStage();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (TimeData["IsRequire"]) then
				clear_server_timer("Nemeres_Watchtower_Time_Out", get_server_timer_arg());
				server_timer("Nemeres_Watchtower_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			if (Lv == 0) then
				Nemeres_Watchtower_Library.SetWaitTime();
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Nemeres_Watchtower.Prepare(1);
			end -- if
		end -- when

		when Nemeres_Watchtower_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Nemere's Watchtower.");
				d.exit_all();
			end -- if
		end -- when

		function Prepare(stage)
			local Data = Nemeres_Watchtower_Library.ReturnData();

			if (Nemeres_Watchtower_Library.GetDungeonStage() == stage) then
				return;
			end -- if

			Nemeres_Watchtower_Library.SetNewDungeonStage();

			if is_test_server() or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. stage .. ".");
			end -- if

			if (1 == stage) then
				d.notice("Defeat all monsters.");

				d.regen_file("data/dungeon/nemeres_watchtower/regen_01.txt");
			end -- if

			if (2 == stage) then
				d.notice("Defeat the monsters until you find the correct Frost Key.");

				d.set_regen_file("data/dungeon/nemeres_watchtower/regen_02.txt");

				local FirstStagePos = Data["1st_Teleport_Coords"];
				d.jump_all(FirstStagePos["x"], FirstStagePos["y"]);
			end -- if

			if (3 == stage) then
				d.notice("Defeat all monsters.");

				d.regen_file("data/dungeon/nemeres_watchtower/regen_03.txt");

				local SecondStagePos = Data["2nd_Teleport_Coords"];
				d.jump_all(SecondStagePos["x"], SecondStagePos["y"]);
			end -- if

			if (4 == stage) then
				d.notice("Defeat all monsters.");

				d.regen_file("data/dungeon/nemeres_watchtower/regen_04.txt");

				local ThirdStagePos = Data["3rd_Teleport_Coords"];
				d.jump_all(ThirdStagePos["x"], ThirdStagePos["y"]);
			end -- if

			if (5 == stage) then
				d.notice("Kill monsters to drop the North Star to unlock all 5 Arctic Cube.");

				d.set_regen_file("data/dungeon/nemeres_watchtower/regen_05.txt");

				d.setf("Arctic_Cube_Count", 6);

				d.spawn_mob(20398, 432, 508);
				d.spawn_mob(20398, 437, 493);
				d.spawn_mob(20398, 448, 492);
				d.spawn_mob(20398, 448, 476);
				d.spawn_mob(20398, 467, 475);

				local FourthStagePos = Data["4th_Teleport_Coords"];
				d.jump_all(FourthStagePos["x"], FourthStagePos["y"]);
			end -- if

			if (6 == stage) then
				d.notice("Defeat all monsters.");

				d.regen_file("data/dungeon/nemeres_watchtower/regen_06.txt");

				local FifthStagePos = Data["5th_Teleport_Coords"];
				d.jump_all(FifthStagePos["x"], FifthStagePos["y"]);
			end -- if

			if (7 == stage) then
				d.notice("Find and destroy the correct Szel.");

				d.regen_file("data/dungeon/nemeres_watchtower/regen_07.txt");

				local SzelPosition = {
					{288, 672}, {288, 642}, {319, 642}, {318, 672}
				};

				for index = 1, table.getn(SzelPosition) - 1, 1 do
					local RandomNumber = math.random(table.getn(SzelPosition));
					d.spawn_mob(6151, SzelPosition[RandomNumber][1], SzelPosition[RandomNumber][2]);
					table.remove(SzelPosition, RandomNumber);
				end -- for

				local RealSzelVID = d.spawn_mob(6151, SzelPosition[1][1], SzelPosition[1][2]);
				d.set_unique("Real_Szel", RealSzelVID);

				local SixthStagePos = Data["6th_Teleport_Coords"];
				d.jump_all(SixthStagePos["x"], SixthStagePos["y"]);
			end -- if

			if (8 == stage) then
				d.notice("Defeat the monsters until you find the Frostflower Key.");

				d.set_regen_file("data/dungeon/nemeres_watchtower/regen_08.txt");

				local SeventhStagePos = Data["7th_Teleport_Coords"];
				d.jump_all(SeventhStagePos["x"], SeventhStagePos["y"]);
			end -- if

			if (9 == stage) then
				d.notice("Defeat North Dragon Pillar.");

				d.regen_file("data/dungeon/nemeres_watchtower/regen_09.txt");

				d.spawn_mob(20399, 849, 650);

				local EighthStagePos = Data["8th_Teleport_Coords"];
				d.jump_all(EighthStagePos["x"], EighthStagePos["y"]);
			end -- if

			if (10 == stage) then
				d.notice("Defeat Nemere.");

				d.spawn_mob(6191, 928, 335);

				local NinthStagePos = Data["9th_Teleport_Coords"];
				d.jump_all(NinthStagePos["x"], NinthStagePos["y"]);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Nemeres_Watchtower_Library.IsInDungeon() begin
			local Lv = Nemeres_Watchtower_Library.GetDungeonStage();

			if (1 == Lv) then
				if d.count_monster() <= 10 then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
				end -- if
			end -- if

			if (2 == Lv) then
				local Data = Nemeres_Watchtower_Library.ReturnData();

				if (math.random(Data["Frost_Key_Math_Random"]) <= Data["Frost_Key_Chance"]) then
					game.drop_item(Data["Frost_Key_Vnum"], Data["Frost_Key_Count"]);
					ClearDungeon(true);
				end -- if
			end -- if

			if (3 == Lv) then
				if d.count_monster() <= 10 then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
				end -- if
			end -- if

			if (4 == Lv) then
				if d.count_monster() <= 10 then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
				end -- if
			end -- if

			if (5 == Lv) then
				local Data = Nemeres_Watchtower_Library.ReturnData();

				if (math.random(Data["North_Star_Key_Math_Random"]) <= Data["North_Star_Key_Chance"]) then
					game.drop_item(Data["North_Star_Key_Vnum"], Data["North_Star_Key_Count"]);
				end -- if
			end -- if

			if (6 == Lv) then
				if d.count_monster() <= 10 and d.getf("Kill_Stone_Count") == 0 then
					d.notice("Defeat Metin of Cold.");
					ClearDungeon(true);
					d.spawn_mob(8058, 745, 496);
					d.setf("Kill_Stone_Count", 1);
				end -- if

				if (npc.get_race() == 8058) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
				end -- if
			end -- if

			if (7 == Lv) then
				local NPCVID = npc.get_vid(); local RealSzelVID = d.get_unique_vid("Real_Szel");
				if (npc.get_race() == 6151) then
					if (NPCVID == RealSzelVID) then
						d.notice("You have beaten the correct Szel.");
						d.notice("You completed the task. The next task will be in 5 seconds.");
						timer("timer", 5);
						ClearDungeon(true);
					else
						d.notice("You have defeated an invalid Szel.");
					end -- if
				end -- if
			end -- if

			if (8 == Lv) then
				local Data = Nemeres_Watchtower_Library.ReturnData();

				if (math.random(Data["Frostflower_Key_Math_Random"]) <= Data["Frostflower_Key_Chance"]) then
					game.drop_item(Data["Frostflower_Key_Vnum"], Data["Frostflower_Key_Count"]);
				end -- if
			end -- if

			if (9 == Lv) then
				if (npc.get_race() == 20399) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
				end -- if
			end -- if

			if (10 == Lv) then
				if (npc.get_race() == 6191) then
					local Data = Nemeres_Watchtower_Library.ReturnData();

					local DungeonTime = get_time() - d.getf("DungeonTime");

					d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
					if party.is_party() then
						notice_all(string.format("The group founded by %s completed dungeon - Nemere's Watchtower in %s.", pc.name, Get_Time_Format(DungeonTime)));
					else
						notice_all(string.format("Player %s completed dungeon - Nemere's Watchtower in %s.", pc.name, Get_Time_Format(DungeonTime)));
					end -- if

					timer("ExitDung", 30);
					ClearDungeon(true);
					d.finish();
				end -- if
			end -- if
		end -- when

		when 30331.use with (Nemeres_Watchtower_Library.IsInDungeon() and Nemeres_Watchtower_Library.GetDungeonStage() == 2) begin
			d.notice("You completed the task. The next task will be in 5 seconds.");
			local DeleteItem = {30331};
			for index in DeleteItem do
				if (pc.count_item(DeleteItem[index]) > 0) then
					pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
				end -- if
			end -- for
			timer("timer", 5);
			ClearDungeon(true);
		end -- when

		when 20398.take or 20398.click with (Nemeres_Watchtower_Library.IsInDungeon() and Nemeres_Watchtower_Library.GetDungeonStage() == 5) begin
			if item.vnum == 30332 then
				d.setf("Arctic_Cube_Count", d.getf("Arctic_Cube_Count") - 1);
				npc.purge();

				local DeleteItem = {30332};
				for index in DeleteItem do
					pc.remove_item(DeleteItem[index], 1);
				end -- for

				if d.getf("Arctic_Cube_Count") == 5 then
					d.notice("Open Arctic Cube. Left: " .. (d.getf("Arctic_Cube_Count") - 1) .. ".");
				elseif d.getf("Arctic_Cube_Count") == 4 then
					d.notice("Open Arctic Cube. Left: " .. (d.getf("Arctic_Cube_Count") - 1) .. ".");
				elseif d.getf("Arctic_Cube_Count") == 3 then
					d.notice("Open Arctic Cube. Left: " .. (d.getf("Arctic_Cube_Count") - 1) .. ".");
				elseif d.getf("Arctic_Cube_Count") == 2 then
					d.notice("Open Arctic Cube. Left: " .. (d.getf("Arctic_Cube_Count") - 1) .. ".");
				elseif d.getf("Arctic_Cube_Count") == 1 then
					d.setf("Arctic_Cube_Count", 0);
					d.notice("Arctic Cube has been destroyed.");
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
				end -- if
			end -- if
		end -- when

		when 30333.use with (Nemeres_Watchtower_Library.IsInDungeon() and Nemeres_Watchtower_Library.GetDungeonStage() == 8) begin
			d.notice("You completed the task. The next task will be in 5 seconds.");
			local DeleteItem = {30333};
			for index in DeleteItem do
				if (pc.count_item(DeleteItem[index]) > 0) then
					pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
				end -- if
			end -- for
			timer("timer", 5);
			ClearDungeon(true);
		end -- when

		when ExitDung.timer with Nemeres_Watchtower_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Nemere's Watchtower.");
			d.exit_all();
		end -- when

		when timer.timer with Nemeres_Watchtower_Library.IsInDungeon() begin
			local Lv = Nemeres_Watchtower_Library.GetDungeonStage();

			if Lv == 1 then
				Nemeres_Watchtower.Prepare(2);
			end -- if

			if Lv == 2 then
				Nemeres_Watchtower.Prepare(3);
			end -- if

			if Lv == 3 then
				Nemeres_Watchtower.Prepare(4);
			end -- if

			if Lv == 4 then
				Nemeres_Watchtower.Prepare(5);
			end -- if

			if Lv == 5 then
				Nemeres_Watchtower.Prepare(6);
			end -- if

			if Lv == 6 then
				Nemeres_Watchtower.Prepare(7);
			end -- if

			if Lv == 7 then
				Nemeres_Watchtower.Prepare(8);
			end -- if

			if Lv == 8 then
				Nemeres_Watchtower.Prepare(9);
			end -- if

			if Lv == 9 then
				Nemeres_Watchtower.Prepare(10);
			end -- if
		end -- when
	end -- state
end -- quest
