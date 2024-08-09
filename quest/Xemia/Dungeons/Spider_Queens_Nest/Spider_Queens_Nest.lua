quest Spider_Queens_Nest begin
	state start begin
		when login with (Spider_Queens_Nest_Library.IsInDungeon()) begin
			local Data = Spider_Queens_Nest_Library.ReturnData();
			local Lv = Spider_Queens_Nest_Library.GetDungeonStage();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (TimeData["IsRequire"]) then
				clear_server_timer("Spider_Queens_Nest_Time_Out", get_server_timer_arg());
				server_timer("Spider_Queens_Nest_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			Dungeon_Task_Helper.RegisterListener();

			if (Lv == 0) then
				Spider_Queens_Nest_Library.SetWaitTime();
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Spider_Queens_Nest.Prepare(1);
				Dungeon_Task_Helper.ClearGlobalTimer();
				Dungeon_Task_Helper.SetGlobalTimer();
			end -- if
		end -- when

		when Spider_Queens_Nest_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Spider Queen's Nest.")
				d.exit_all();
			end -- if
		end -- when

		function Prepare(Stage)
			local Data = Spider_Queens_Nest_Library.ReturnData();

			if (Spider_Queens_Nest_Library.GetDungeonStage() == Stage) then
				return;
			end -- if

			Spider_Queens_Nest_Library.SetNewDungeonStage();

			Dungeon_Task_Helper.PopState();
			Dungeon_Task_Helper.SendStateInfo();

			if is_test_server() or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. Stage .. ".")
			end -- if

			if (1 == Stage) then
				d.notice("Defeat the first wave of monsters.")

				d.set_regen_file("data/dungeon/spider_queens_nest/regen_01.txt");
			end -- if

			if (2 == Stage) then
				d.notice("Defeat the second wave of monsters.")

				d.set_regen_file("data/dungeon/spider_queens_nest/regen_02.txt");
			end -- if

			if (3 == Stage) then
				d.notice("Destroy all Spider Eggs to face the Elite Spider Queen.")

				d.set_regen_file("data/dungeon/spider_queens_nest/regen_03.txt");

				d.spawn_mob(2095, 70, 135);
				d.spawn_mob(2095, 100, 135);
				d.spawn_mob(2095, 70, 110);
				d.spawn_mob(2095, 100, 110);

				local FirstStagePos = Data["1st_Teleport_Coords"];
				d.jump_all(FirstStagePos["x"], FirstStagePos["y"]);
			end -- if

			if (4 == Stage) then
				d.notice("Defeat the Elite Spider Queen.")

				d.spawn_mob(2094, 85, 115);
			end -- if

			if (5 == Stage) then
				d.notice("Summon Spider Eggs using Spider Venom. You can get Spider Venom from monsters.")

				d.set_regen_file("data/dungeon/spider_queens_nest/regen_04.txt");

				d.setf("Ancient_Seal_Count", 5);

				d.set_unique("Ancient_Seal_01", d.spawn_mob(61002, 325, 85));
				d.set_unique("Ancient_Seal_02", d.spawn_mob(61002, 425, 85));
				d.set_unique("Ancient_Seal_03", d.spawn_mob(61002, 325, 165));
				d.set_unique("Ancient_Seal_04", d.spawn_mob(61002, 425, 165));

				local SecondStagePos = Data["2nd_Teleport_Coords"];
				d.jump_all(SecondStagePos["x"], SecondStagePos["y"]);
			end -- if

			if (6 == Stage) then
				d.notice("Kill spiders to get the Spider Flute, they must be poisoned or fainted to be injured.")

				d.set_regen_file("data/dungeon/spider_queens_nest/regen_05.txt");

				local ThirdStagePos = Data["3rd_Teleport_Coords"];
				d.jump_all(ThirdStagePos["x"], ThirdStagePos["y"]);
			end -- if

			if (7 == Stage) then
				d.notice("Defeat Spider Baroness.")

				d.spawn_mob(2092, 388, 428);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Spider_Queens_Nest_Library.IsInDungeon() begin
			local Lv = Spider_Queens_Nest_Library.GetDungeonStage();

			if (1 == Lv) then
				if d.count_monster() <= 150 then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					ClearDungeon(true);
					timer("timer", 5);
				end -- if
			end -- if

			if (2 == Lv) then
				if d.count_monster() <= 150 then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					ClearDungeon(true);
					timer("timer", 5);
				end -- if
			end -- if

			if (3 == Lv) then
				if (npc.get_race() == 2095) then
					d.setf("Kill_Metin_Stone", d.getf("Kill_Metin_Stone") + 1);
					if (d.getf("Kill_Metin_Stone") >= 4) then
						d.notice("You completed the task. The next task will be in 5 seconds.");
						d.setf("Kill_Metin_Stone", 0);
						ClearDungeon(true);
						timer("timer", 5);
					end -- if
				end -- if
			end -- if

			if (4 == Lv) then
				if (npc.get_race() == 2094) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					ClearDungeon(true);
					timer("timer", 5);
				end -- if
			end -- if

			if (5 == Lv) then
				local Data = Spider_Queens_Nest_Library.ReturnData();

				if (math.random(Data["Spider_Queens_Poison_Math_Random"]) <= Data["Spider_Queens_Poison_Chance"]) then
					game.drop_item(Data["Spider_Queens_Poison_Vnum"], Data["Spider_Queens_Poison_Count"]);
				end -- if

				if (npc.get_race() == 2096) then
					d.setf("Kill_Metin_Stone", d.getf("Kill_Metin_Stone") + 1);
					game.drop_item(Data["Key_Stone_Vnum"], Data["Key_Stone_Count"]);
					if (d.getf("Kill_Metin_Stone") >= 4) then
						d.setf("Kill_Metin_Stone", 0);
					end -- if
				end -- if

				if (npc.get_race() == 2094) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					ClearDungeon(true);
					timer("timer", 5);
				end -- if
			end -- if

			if (6 == Lv) then
				local Data = Spider_Queens_Nest_Library.ReturnData();

				if (math.random(Data["Arachnids_Whistle_Math_Random"]) <= Data["Arachnids_Whistle_Chance"]) then
					game.drop_item(Data["Arachnids_Whistle_Vnum"], Data["Arachnids_Whistle_Count"]);
					ClearDungeon(true);
				end -- if
			end -- if

			if (7 == Lv) then
				if (npc.get_race() == 2092) then
					local Data = Spider_Queens_Nest_Library.ReturnData();

					local DungeonTime = get_time() - d.getf("DungeonTime");

					d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
					if party.is_party() then
						notice_all(string.format("The group founded by %s completed dungeon - Spider Queen's Nest in %s.", pc.name, Get_Time_Format(DungeonTime)))
					else
						notice_all(string.format("Player %s completed dungeon - Spider Queen's Nest in %s.", pc.name, Get_Time_Format(DungeonTime)))
					end -- if

					timer("ExitDung", 30);
					ClearDungeon(true);
					d.finish();
				end -- if
			end -- if
		end -- when

		when 176201.use with (Spider_Queens_Nest_Library.IsInDungeon() and Spider_Queens_Nest_Library.GetDungeonStage() == 5) begin
			local DeleteItem = {176201};
			for index in DeleteItem do
				pc.remove_item(DeleteItem[index], 1);
			end -- for

			if d.getf("Respawn_Metin_Stone") <= 3 then
				d.setf("Respawn_Metin_Stone", d.getf("Respawn_Metin_Stone") + 1);
			end -- if

			if (d.getf("Respawn_Metin_Stone") == 1 and d.getf("Respawn_Metin_Stone_Done_01") == 0) then
				d.setf("Respawn_Metin_Stone_Done_01", d.getf("Respawn_Metin_Stone_Done_01") + 1);
				d.spawn_mob(2096, 345, 105);
			elseif (d.getf("Respawn_Metin_Stone") == 2 and d.getf("Respawn_Metin_Stone_Done_02") == 0) then
				d.setf("Respawn_Metin_Stone_Done_02", d.getf("Respawn_Metin_Stone_Done_02") + 1);
				d.spawn_mob(2096, 400, 105);
			elseif (d.getf("Respawn_Metin_Stone") == 3 and d.getf("Respawn_Metin_Stone_Done_03") == 0) then
				d.setf("Respawn_Metin_Stone_Done_03", d.getf("Respawn_Metin_Stone_Done_03") + 1);
				d.spawn_mob(2096, 400, 150);
			elseif (d.getf("Respawn_Metin_Stone") == 4 and d.getf("Respawn_Metin_Stone_Done_04") == 0) then
				d.setf("Respawn_Metin_Stone_Done_04", d.getf("Respawn_Metin_Stone_Done_04") + 1);
				d.spawn_mob(2096, 345, 150);
			end -- if
		end -- when

		when 61002.take or 61002.click or 176202.use with (Spider_Queens_Nest_Library.IsInDungeon() and Spider_Queens_Nest_Library.GetDungeonStage() == 5) begin
			if item.vnum == 176202 then
				d.setf("Ancient_Seal_Count", d.getf("Ancient_Seal_Count") - 1);

				local DeleteItem = {176202};
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
					ClearDungeon(true);
					d.spawn_mob(2094, 395, 140);
				end -- if
			end -- if
		end -- when

		when 176203.use with (Spider_Queens_Nest_Library.IsInDungeon() and Spider_Queens_Nest_Library.GetDungeonStage() == 6) begin
			d.notice("You completed the task. The next task will be in 5 seconds.");
			local DeleteItem = {176203};
			for index in DeleteItem do
				if (pc.count_item(DeleteItem[index]) > 0) then
					pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
				end -- if
			end -- for
			timer("timer", 5);
		end -- when

		when ExitDung.timer with Spider_Queens_Nest_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Spider Queen's Nest.")
			d.exit_all();
		end -- when

		when timer.timer with Spider_Queens_Nest_Library.IsInDungeon() begin
			local Lv = Spider_Queens_Nest_Library.GetDungeonStage();

			if Lv == 1 then
				Spider_Queens_Nest.Prepare(2);
			end -- if

			if Lv == 2 then
				Spider_Queens_Nest.Prepare(3);
			end -- if

			if Lv == 3 then
				Spider_Queens_Nest.Prepare(4);
			end -- if

			if Lv == 4 then
				Spider_Queens_Nest.Prepare(5);
			end -- if

			if Lv == 5 then
				Spider_Queens_Nest.Prepare(6);
			end -- if

			if Lv == 6 then
				Spider_Queens_Nest.Prepare(7);
			end -- if
		end -- when
	end -- state
end -- quest
