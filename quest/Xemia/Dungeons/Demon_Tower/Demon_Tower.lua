quest Demon_Tower begin
	state start begin
		when 20348.chat."(Lv. 40) Demon Tower" begin
			local Data = Demon_Tower_Library.ReturnData();
			local LevelRequire = Data["LevelRequire"];
			local GroupRequire = Data["GroupRequire"];
			local GoldRequire = Data["GoldRequire"];

			if party.is_party() and not party.is_leader() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say_reward("You are not a group leader. Let me talk to him.")
				say("")
				return;
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say_reward("Welcome to the entrance to the Demon Tower.")
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
			if (pc.money < GoldRequire["GoldCount"]) then
				say(string.format("Pass: |cFFFF00001.000.000 Yang", LevelRequire["MaximumLevel"]))
			else
				say(string.format("Pass: |cFF0099001.000.000 Yang", LevelRequire["MaximumLevel"]))
			end
			if party.is_party() then
				if (party.get_near_count() < 1) then
					say(string.format("Group: |cFFFF0000%d|r/|cFF009900%d", party.get_near_count(), GroupRequire["MaximumPartyMemebers"]))
				else
					say(string.format("Group: |cFF009900%d|r/|cFF009900%d", party.get_near_count(), GroupRequire["MaximumPartyMemebers"]))
				end -- if
			else
				say("Group: |cFF009900You don't have a Group")
			end -- if
			say("")
			say_reward("Do you want to enter the Demon Tower?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Demon_Tower_Library.CheckRequire()) then
					Demon_Tower_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 20348.chat."(Lv. 40) Demon Tower - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return
			end -- if
		end -- when

		when login with (Demon_Tower_Library.IsInDungeon()) begin
			local Data = Demon_Tower_Library.ReturnData();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (party.is_party() and party.is_leader() or not party.is_party()) then
				local TimeData = Data["TimeData"]["TimeToCompleteData"];
				if (TimeData["IsRequire"]) then
					clear_server_timer("Demon_Tower_Time_Out", get_server_timer_arg());
					server_timer("Demon_Tower_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
				end -- if
			end -- if

			Dungeon_Task_Helper.RegisterListener();

			local Lv = Demon_Tower_Library.GetDungeonStage();
			if (Lv == 0) then
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Demon_Tower.Prepare(1);
				Dungeon_Task_Helper.SetGlobalTimer();
			end -- if
		end -- when

		when Demon_Tower_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Demon Tower.")
				d.exit_all();
			end -- if
		end -- when

		function Prepare(Stage)
			local Data = Demon_Tower_Library.ReturnData();

			if (Demon_Tower_Library.GetDungeonStage() == Stage) then
				return
			end -- if

			Demon_Tower_Library.SetNewDungeonStage();

			Dungeon_Task_Helper.PopState();
			Dungeon_Task_Helper.SendStateInfo();

			if is_test_server() or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. Stage .. ".")
			end -- if

			if (1 == Stage) then
				d.notice("Destroy Metin of Toughness to get to the next stage.")

				d.set_regen_file("data/dungeon/demon_tower/regen_01.txt");

				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (2 == Stage) then
				d.notice("Defeat Demon King.")

				d.set_regen_file("data/dungeon/demon_tower/regen_02.txt");

				local FirstStagePos = Data["1st_Teleport_Coords"];
				d.jump_all(FirstStagePos["x"], FirstStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (3 == Stage) then
				d.notice("Defeat Metin of Devil.")

				d.set_regen_file("data/dungeon/demon_tower/regen_03.txt");

				local SecondStagePos = Data["2nd_Teleport_Coords"];
				d.jump_all(SecondStagePos["x"], SecondStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (4 == Stage) then
				d.notice("Find and destroy the correct Metin of Fall.")

				local MetinStonePosition = {
					{368, 629}, {419, 630}, {428, 653}, {422, 679},
					{395, 689}, {369, 679}, {361, 658}
				};

				for index = 1, table.getn(MetinStonePosition) - 1, 1 do
					local RandomNumber = math.random(table.getn(MetinStonePosition));
					d.spawn_mob(8017, MetinStonePosition[RandomNumber][1], MetinStonePosition[RandomNumber][2]);
					table.remove(MetinStonePosition, RandomNumber);
				end -- for

				local RealMetinStoneVID = d.spawn_mob(8017, MetinStonePosition[1][1], MetinStonePosition[1][2]);
				d.set_unique("Real_Metin_Stone", RealMetinStoneVID);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (5 == Stage) then
				d.notice("Kill monsters to get Key Stone. It will be necessary to open all 5 Ancient Seal.")

				d.setf("Ancient_Seal_Count", 6);

				d.set_unique("Ancient_Seal_01", d.spawn_mob(20073, 421, 452));
				d.set_unique("Ancient_Seal_02", d.spawn_mob(20073, 380, 460));
				d.set_unique("Ancient_Seal_03", d.spawn_mob(20073, 428, 414));
				d.set_unique("Ancient_Seal_04", d.spawn_mob(20073, 398, 392));
				d.set_unique("Ancient_Seal_05", d.spawn_mob(20073, 359, 426));

				d.set_regen_file("data/dungeon/demon_tower/regen_04.txt");

				local ThirdStagePos = Data["3rd_Teleport_Coords"];
				d.jump_all(ThirdStagePos["x"], ThirdStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(5);
			end -- if

			if (6 == Stage) then
				d.notice("Defeat Proud Demon King.")

				d.set_regen_file("data/dungeon/demon_tower/regen_05.txt");

				local FourthStagePos = Data["4th_Teleport_Coords"];
				d.jump_all(FourthStagePos["x"], FourthStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(41);
			end -- if

			if (7 == Stage) then
				d.notice("The Blacksmith has appeared, you can choose the next way.")

				local Data = Demon_Tower_Library.ReturnData();
				local Blacksmiths = Data["Blacksmiths"];

				d.setqf("Can_Refine", Data["Allowed_Refines"]);
				d.spawn_mob(Blacksmiths[math.random(3)], 425, 216);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (8 == Stage) then
				d.notice("Destroy all Metin of Death.")

				d.spawn_mob(8018, 639, 658);
				d.spawn_mob(8018, 611, 637);
				d.spawn_mob(8018, 596, 674);
				d.spawn_mob(8018, 629, 670);

				local FifthStagePos = Data["5th_Teleport_Coords"];
				d.jump_all(FifthStagePos["x"], FifthStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(4);
			end -- if

			if (9 == Stage) then
				d.notice("Defeat Metin of Murder to get Zin-Sa-Gui Tower Map.")

				d.set_regen_file("data/dungeon/demon_tower/regen_06.txt");

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (10 == Stage) then
				d.notice("Drop the Zin-Bong-In Key and place it on Sa-Soe.")

				d.set_regen_file("data/dungeon/demon_tower/regen_07.txt");

				local SixthStagePos = Data["6th_Teleport_Coords"];
				d.jump_all(SixthStagePos["x"], SixthStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (11 == Stage) then
				d.notice("Defeat Death Reaper.")

				d.regen_file("data/dungeon/demon_tower/regen_boss.txt");

				local SeventhStagePos = Data["7th_Teleport_Coords"];
				d.jump_all(SeventhStagePos["x"], SeventhStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Demon_Tower_Library.IsInDungeon() begin
			local Lv = Demon_Tower_Library.GetDungeonStage();

			if (1 == Lv) then
				if (npc.get_race() == 8015) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					Dungeon_Task_Helper.IncCounter(1);
				end -- if
			end -- if

			if (2 == Lv) then
				if (npc.get_race() == 1091) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
				end -- if
			end -- if

			if (3 == Lv) then
				if (npc.get_race() == 8016) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
				end -- if
			end -- if

			if (4 == Lv) then
				local NPCVID = npc.get_vid();
				local RealMetinStoneVID = d.get_unique_vid("Real_Metin_Stone");
				if (npc.get_race() == 8017) then
					if (NPCVID == RealMetinStoneVID) then
						d.notice("A valid Metin of Fall has been defeated.")
						d.notice("You completed the task. The next task will be in 5 seconds.");
						timer("timer", 5);
						ClearDungeon(true);
						Dungeon_Task_Helper.IncCounter(1);
					else
						d.notice("This Metin of Fall is false.")
					end -- if
				end -- if
			end -- if

			if (5 == Lv) then
				local Data = Demon_Tower_Library.ReturnData();

				if (math.random(Data["Key_Stone_Math_Random"]) <= Data["Key_Stone_Chance"]) then
					game.drop_item(Data["Key_Stone_Vnum"], Data["Key_Stone_Count"]);
				end -- if
			end -- if

			if (6 == Lv) then
				if (npc.get_race() == 1092) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
				end -- if
			end -- if

			if (7 == Lv) then
			end -- if

			if (8 == Lv) then
				if (npc.get_race() == 8018) and d.getf("Kill_Metin_Stone") < 4 then
					d.setf("Kill_Metin_Stone", d.getf("Kill_Metin_Stone") + 1)
					Dungeon_Task_Helper.IncCounter(1);
					if d.getf("Kill_Metin_Stone") == 4 then
						d.notice("You completed the task. The next task will be in 5 seconds.");
						d.setf("Kill_Metin_Stone", 0);
						timer("timer", 5);
						ClearDungeon(true);
					end -- if
				end -- if
			end -- if

			if (9 == Lv) then
				if (npc.get_race() == 8019) then
					local Data = Demon_Tower_Library.ReturnData();

					if (math.random(Data["Zin_Sa_Gui_Tower_Map_Math_Random"]) <= Data["Zin_Sa_Gui_Tower_Map_Chance"]) then
						game.drop_item(Data["Zin_Sa_Gui_Tower_Map_Vnum"], Data["Zin_Sa_Gui_Tower_Map_Count"]);
					end -- if
				end -- if
			end -- if

			if (10 == Lv) then
				local Data = Demon_Tower_Library.ReturnData();

				if (math.random(Data["Zin_Bong_In_Key_Math_Random"]) <= Data["Zin_Bong_In_Key_Chance"]) then
					game.drop_item(Data["Zin_Bong_In_Key_Vnum"], Data["Zin_Bong_In_Key_Count"]);
					ClearDungeon(true);
					d.spawn_mob(20366, 640, 460);
				end -- if
			end -- if

			if (11 == Lv) then
				if (npc.get_race() == 1093) then
					local Data = Demon_Tower_Library.ReturnData();

					local DungeonTime = get_time() - d.getf("DungeonTime");

					d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
					if party.is_party() then
						notice_all(string.format("The group founded by %s completed dungeon - Demon Tower in %s.", pc.name, Get_Time_Format(DungeonTime)))
					else
						notice_all(string.format("Player %s completed dungeon - Demon Tower in %s.", pc.name, Get_Time_Format(DungeonTime)))
					end -- if

					timer("ExitDung", 30);
					ClearDungeon(true);
					d.finish();
					Dungeon_Task_Helper.IncCounter(1);
				end -- if
			end -- if
		end -- when

		when 20073.take or 20073.click or 50084.use with (Demon_Tower_Library.IsInDungeon() and Demon_Tower_Library.GetDungeonStage() == 5) begin
			if item.vnum == 50084 then
				d.setf("Ancient_Seal_Count", d.getf("Ancient_Seal_Count") - 1);

				local DeleteItem = {50084};
				for index in DeleteItem do
					pc.remove_item(DeleteItem[index], 1);
				end -- for

				Dungeon_Task_Helper.IncCounter(1);

				if d.getf("Ancient_Seal_Count") == 5 then
					d.notice("The seal has been opened. Left: " .. (d.getf("Ancient_Seal_Count") - 1) .. ".")
					d.purge_unique("Ancient_Seal_01");
				elseif d.getf("Ancient_Seal_Count") == 4 then
					d.notice("The seal has been opened. Left: " .. (d.getf("Ancient_Seal_Count") - 1) .. ".")
					d.purge_unique("Ancient_Seal_02");
				elseif d.getf("Ancient_Seal_Count") == 3 then
					d.notice("The seal has been opened. Left: " .. (d.getf("Ancient_Seal_Count") - 1) .. ".")
					d.purge_unique("Ancient_Seal_03");
				elseif d.getf("Ancient_Seal_Count") == 2 then
					d.notice("The seal has been opened. Left: " .. (d.getf("Ancient_Seal_Count") - 1) .. ".")
					d.purge_unique("Ancient_Seal_04");
				elseif d.getf("Ancient_Seal_Count") == 1 then
					d.setf("Ancient_Seal_Count", 0);
					d.purge_unique("Ancient_Seal_05");
					d.notice("All the seals have been opened.")
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
				end -- if
			end -- if
		end -- when

		when 20074.chat."Upper Stages" or 20075.chat."Upper Stages" or 20076.chat."Upper Stages" with (Demon_Tower_Library.IsInDungeon() and Demon_Tower_Library.GetDungeonStage() == 7) begin
			local Data = Demon_Tower_Library.ReturnData();
			local LevelRequire = Data["LevelRequire"];
			local PlayerLevel = pc.get_level()

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("They found their way to the 7th stage.")
			say("It takes a lot of skills and skill to get there.")
			say("")
			wait();
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("You have chosen to go further, new problems will await you.")
			say("")
			wait();
			local IsNPCBlocked = IsDungeonNPCBlocked();
			if (IsNPCBlocked) then
				say("Another player has already chosen to move on.")
				return;
			end -- if
			BlockDungeonNPC();
			d.notice("You completed the task. The next task will be in 5 seconds.");
			timer("timer", 5);
			ClearDungeon(true);
			Dungeon_Task_Helper.IncCounter(1);
			setskin(NOWINDOW);
		end -- when

		when 30302.use with (Demon_Tower_Library.IsInDungeon() and Demon_Tower_Library.GetDungeonStage() == 9) begin
			if d.getf("Map_Used") == 0 then
				d.notice("You completed the task. The next task will be in 5 seconds.");
				item.remove();
				d.setf("Map_Used", 1);
				timer("timer", 5);
				ClearDungeon(true);
				Dungeon_Task_Helper.IncCounter(1);
			end -- if
		end -- when

		when 20366.take or 20366.click or 30304.use with (Demon_Tower_Library.IsInDungeon() and Demon_Tower_Library.GetDungeonStage() == 10) begin
			if item.vnum == 30304 then
				d.notice("You completed the task. The next task will be in 5 seconds.");
				npc.purge();
				item.remove();
				timer("timer", 5);
				ClearDungeon(true);
				Dungeon_Task_Helper.IncCounter(1);
			end -- if
		end -- when

		when ExitDung.timer with Demon_Tower_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Demon Tower.")
			d.exit_all();
		end -- when

		when timer.timer with Demon_Tower_Library.IsInDungeon() begin
			local Lv = Demon_Tower_Library.GetDungeonStage();

			if Lv == 1 then
				Demon_Tower.Prepare(2);
			end -- if

			if Lv == 2 then
				Demon_Tower.Prepare(3);
			end -- if

			if Lv == 3 then
				Demon_Tower.Prepare(4);
			end -- if

			if Lv == 4 then
				Demon_Tower.Prepare(5);
			end -- if

			if Lv == 5 then
				Demon_Tower.Prepare(6);
			end -- if

			if Lv == 6 then
				Demon_Tower.Prepare(7);
			end -- if

			if Lv == 7 then
				Demon_Tower.Prepare(8);
			end -- if

			if Lv == 8 then
				Demon_Tower.Prepare(9);
			end -- if

			if Lv == 9 then
				Demon_Tower.Prepare(10);
			end -- if

			if Lv == 10 then
				Demon_Tower.Prepare(11);
			end -- if
		end -- when
	end -- state
end -- quest
