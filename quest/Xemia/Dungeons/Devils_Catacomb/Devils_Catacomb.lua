quest Devils_Catacomb begin
	state start begin
		when 20367.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when 20367.chat."(Lv. 75) Devil's Catacomb" begin
			local Data = Devils_Catacomb_Library.ReturnData();
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
			say_reward("Welcome to the entrance to the Devil's Catacomb.")
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
			say_reward("Do you want to enter the Devil's Catacomb?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Devils_Catacomb_Library.CheckRequire()) then
					Devils_Catacomb_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 20367.chat."(Lv. 75) Devil's Catacomb - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return;
			end -- if
		end -- when

		when login with (Devils_Catacomb_Library.IsInDungeon()) begin
			local Data = Devils_Catacomb_Library.ReturnData();
			local Lv = Devils_Catacomb_Library.GetDungeonStage();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (TimeData["IsRequire"]) then
				clear_server_timer("Devils_Catacomb_Time_Out", get_server_timer_arg());
				server_timer("Devils_Catacomb_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			Dungeon_Task_Helper.RegisterListener();

			if (Lv == 0) then
				Devils_Catacomb_Library.SetWaitTime();
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Devils_Catacomb.Prepare(1);
				Dungeon_Task_Helper.SetGlobalTimer();
			end -- if
		end -- when

		when Devils_Catacomb_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Devil's Catacomb.")
				d.exit_all();
			end -- if
		end -- when

		function Prepare(Stage)
			local Data = Devils_Catacomb_Library.ReturnData();

			if (Devils_Catacomb_Library.GetDungeonStage() == Stage) then
				return;
			end -- if

			Devils_Catacomb_Library.SetNewDungeonStage();

			if is_test_server() or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. Stage .. ".")
			end -- if

			Dungeon_Task_Helper.PopState();
			Dungeon_Task_Helper.SendStateInfo();

			if (1 == Stage) then
				d.notice("Get Soul Crystal Key from monsters and move to Kud Statue.")

				d.set_regen_file("data/dungeon/devils_catacomb/regen_01.txt");

				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (2 == Stage) then
				d.notice("Defeat all Gate of Perdition and click on Tortoise Rock.")

				d.regen_file("data/dungeon/devils_catacomb/regen_02.txt");

				local FirstStagePos = Data["1st_Teleport_Coords"];
				d.jump_all(FirstStagePos["x"], FirstStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (3 == Stage) then
				d.notice("Find and destroy the correct Metin of Resentment.")

				local MetinStonePosition = {
					{1250, 250}, {1250, 350}, {1350, 350}, {1250, 150},
					{1350, 150}, {1150, 250}, {1146, 348}, {1149, 150}
				};

				for index = 1, table.getn(MetinStonePosition) - 1, 1 do
					local RandomNumber = math.random(table.getn(MetinStonePosition));
					d.spawn_mob(8037, MetinStonePosition[RandomNumber][1], MetinStonePosition[RandomNumber][2]);
					table.remove(MetinStonePosition, RandomNumber);
				end -- for

				local RealMetinStoneVID = d.spawn_mob(8037, MetinStonePosition[1][1], MetinStonePosition[1][2]);
				d.set_unique("Real_Metin_Stone", RealMetinStoneVID);

				local SecondStagePos = Data["2nd_Teleport_Coords"];
				d.jump_all(SecondStagePos["x"], SecondStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (4 == Stage) then
				d.notice("Defeat all Metin of Retribution.")

				d.spawn_mob(8038, 517, 792);
				d.spawn_mob(8038, 492, 794);
				d.spawn_mob(8038, 503, 780);

				d.set_regen_file("data/dungeon/devils_catacomb/regen_03.txt");

				local ThirdStagePos = Data["3rd_Teleport_Coords"];
				d.jump_all(ThirdStagePos["x"], ThirdStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(3);
			end -- if

			if (5 == Stage) then
				d.notice("Find and destroy the correct Tartaros.")

				local TartarPosition = {
					{709, 815}, {721, 654}, {851, 597},
					{988, 661}, {982, 834}
				};

				for index = 1, table.getn(TartarPosition) - 1, 1 do
					local RandomNumber = math.random(table.getn(TartarPosition));
					d.spawn_mob(2591, TartarPosition[RandomNumber][1], TartarPosition[RandomNumber][2]);
					table.remove(TartarPosition, RandomNumber);
				end -- for

				local RealTartarVID = d.spawn_mob(2591, TartarPosition[1][1], TartarPosition[1][2]);
				d.set_unique("Real_Tartar", RealTartarVID);

				d.set_regen_file("data/dungeon/devils_catacomb/regen_04.txt");

				local FourthStagePos = Data["4th_Teleport_Coords"];
				d.jump_all(FourthStagePos["x"], FourthStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (6 == Stage) then
				d.notice("Defeat Charon.")

				d.spawn_mob(2597, 1302, 705);

				d.set_regen_file("data/dungeon/devils_catacomb/regen_05.txt");

				local FifthStagePos = Data["5th_Teleport_Coords"];
				d.jump_all(FifthStagePos["x"], FifthStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if

			if (7 == Stage) then
				d.notice("Defeat Azrael.")

				d.spawn_mob(2598, 74, 1108);

				local SixthStagePos = Data["6th_Teleport_Coords"];
				d.jump_all(SixthStagePos["x"], SixthStagePos["y"]);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Devils_Catacomb_Library.IsInDungeon() begin
			local Lv = Devils_Catacomb_Library.GetDungeonStage();

			if (1 == Lv) then
				if (math.random(100) <= 5) then
					d.notice("Move the Soul Crystal Key to the statue to get to the new stage.")
					game.drop_item(30311, 1);
					ClearDungeon(true);
					d.set_regen_file("data/dungeon/devils_catacomb/regen_npc_01.txt");
				end -- if
			end -- if

			if (2 == Lv) then
				if (npc.get_race() == 30111) then
					d.setf("Kill_Metin_Stone", d.getf("Kill_Metin_Stone") + 1);
					if (d.getf("Kill_Metin_Stone") >= 11) then
						d.notice("Click Tortoise Rock to go to the next level.")
						d.setf("Kill_Metin_Stone", 0);
						ClearDungeon(true);
						d.set_regen_file("data/dungeon/devils_catacomb/regen_npc_02.txt");
					end -- if
				end -- if
			end -- if

			if (3 == Lv) then
				local NPCVID = npc.get_vid(); local RealMetinStoneVID = d.get_unique_vid("Real_Metin_Stone");
				if (npc.get_race() == 8037) then
					if (NPCVID == RealMetinStoneVID) then
						d.notice("You beat the correct Metin of Resentment.")
						d.notice("You completed the task. The next task will be in 5 seconds.");
						timer("timer", 5);
						ClearDungeon(true);
						Dungeon_Task_Helper.IncCounter(1);
					else
						d.notice("You defeated an invalid Metin of Resentment.")
					end -- if
				end -- if
			end -- if

			if (4 == Lv) then
				if (npc.get_race() == 8038) then
					d.setf("Kill_Metin_Stone", d.getf("Kill_Metin_Stone") + 1);
					Dungeon_Task_Helper.IncCounter(1);
					if (d.getf("Kill_Metin_Stone") >= 3) then
						d.notice("You completed the task. The next task will be in 5 seconds.");
						d.setf("Kill_Metin_Stone", 0);
						timer("timer", 5);
						ClearDungeon(true);
					end -- if
				end -- if
			end -- if

			if (5 == Lv) then
				local NPCVID = npc.get_vid(); local RealTartarVID = d.get_unique_vid("Real_Tartar");
				if (npc.get_race() == 2591) then
					if (NPCVID == RealTartarVID) then
						d.notice("You have defeated the correct Tartaros.")
						d.notice("Now go from Grimace Totem to the top of the mountain and move it to Basalt Obelisk.")
						game.drop_item(30312, 1);
						ClearDungeon(true);
						d.set_regen_file("data/dungeon/devils_catacomb/regen_npc_03.txt");
					else
						d.notice("You have defeated the wrong Tartaros.")
					end -- if
				end -- if
			end -- if

			if (6 == Lv) then
				if (npc.get_race() == 2597) then
					d.notice("You completed the task. The next task will be in 5 seconds.");
					timer("timer", 5);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
				end -- if
			end -- if

			if (7 == Lv) then
				if (npc.get_race() == 2598) then
					local Data = Devils_Catacomb_Library.ReturnData();

					local DungeonTime = get_time() - d.getf("DungeonTime");

					d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
					if party.is_party() then
						notice_all(string.format("The group founded by %s completed dungeon - Devil's Catacomb in %s.", pc.name, Get_Time_Format(DungeonTime)))
					else
						notice_all(string.format("Player %s completed dungeon - Devil's Catacomb in %s.", pc.name, Get_Time_Format(DungeonTime)))
					end -- if

					timer("ExitDung", 30);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
					d.finish();
				end -- if
			end -- if
		end -- when

		when 30101.take or 30101.click with (Devils_Catacomb_Library.IsInDungeon() and Devils_Catacomb_Library.GetDungeonStage() == 1) begin
			if item.vnum == 30311 then
				local DeleteItem = {30311};
				for index in DeleteItem do
					if (pc.count_item(DeleteItem[index]) > 0) then
						pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
					end -- if
				end -- for

				npc.purge();

				d.notice("You completed the task. The next task will be in 5 seconds.");
				timer("timer", 5);
				npc.purge();
				Dungeon_Task_Helper.IncCounter(1);
			end -- if
		end -- when

		when 30103.click with (Devils_Catacomb_Library.IsInDungeon() and Devils_Catacomb_Library.GetDungeonStage() == 2) begin
			d.notice("You completed the task. The next task will be in 5 seconds.");
			timer("timer", 5);
			npc.purge();
			Dungeon_Task_Helper.IncCounter(1);
		end -- when

		when 30102.take or 30102.click with (Devils_Catacomb_Library.IsInDungeon() and Devils_Catacomb_Library.GetDungeonStage() == 5) begin
			if item.vnum == 30312 then
				local DeleteItem = {30312};
				for index in DeleteItem do
					if (pc.count_item(DeleteItem[index]) > 0) then
						pc.remove_item(DeleteItem[index], pc.count_item(DeleteItem[index]));
					end -- if
				end -- for

				d.notice("You completed the task. The next task will be in 5 seconds.");
				timer("timer", 5);

				npc.purge();

				Dungeon_Task_Helper.IncCounter(1);
			end -- if
		end -- when

		when ExitDung.timer with Devils_Catacomb_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Devil's Catacomb.")
			d.exit_all();
		end -- when

		when timer.timer with Devils_Catacomb_Library.IsInDungeon() begin
			local Lv = Devils_Catacomb_Library.GetDungeonStage();

			if Lv == 1 then
				Devils_Catacomb.Prepare(2);
			end -- if

			if Lv == 2 then
				Devils_Catacomb.Prepare(3);
			end -- if

			if Lv == 3 then
				Devils_Catacomb.Prepare(4);
			end -- if

			if Lv == 4 then
				Devils_Catacomb.Prepare(5);
			end -- if

			if Lv == 5 then
				Devils_Catacomb.Prepare(6);
			end -- if

			if Lv == 6 then
				Devils_Catacomb.Prepare(7);
			end -- if
		end -- when
	end -- state
end -- quest
