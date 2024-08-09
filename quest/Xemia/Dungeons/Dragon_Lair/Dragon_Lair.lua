quest Dragon_Lair begin
	state start begin
		when 30121.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when 30121.chat."(Lv. 75) Dragon Lair" begin
			local Data = Dragon_Lair_Library.ReturnData();
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
			say_reward("Welcome to the entrance to the Dragon Lair.")
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
			say_reward("Do you want to enter the Dragon Lair?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Dragon_Lair_Library.CheckRequire()) then
					Dragon_Lair_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 30121.chat."(Lv. 75) Dragon Lair - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return;
			end -- if
		end -- when

		when login with (Dragon_Lair_Library.IsInDungeon()) begin
			local Data = Dragon_Lair_Library.ReturnData();
			local Lv = Dragon_Lair_Library.GetDungeonStage();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (TimeData["IsRequire"]) then
				clear_server_timer("Dragon_Lair_Time_Out", get_server_timer_arg());
				server_timer("Dragon_Lair_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			Dungeon_Task_Helper.RegisterListener();

			if (Lv == 0) then
				Dragon_Lair_Library.SetWaitTime();
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Dragon_Lair.Prepare(1);
				Dungeon_Task_Helper.SetGlobalTimer();
			end -- if
		end -- when

		when Dragon_Lair_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Dragon Lair.")
				d.exit_all();
			end -- if
		end -- when

		function Prepare(stage)
			local Data = Dragon_Lair_Library.ReturnData();

			if (Dragon_Lair_Library.GetDungeonStage() == stage) then
				return;
			end -- if

			Dragon_Lair_Library.SetNewDungeonStage();

			Dungeon_Task_Helper.PopState();
			Dungeon_Task_Helper.SendStateInfo();

			if is_test_server() or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. stage .. ".")
			end -- if

			if (1 == stage) then
				d.notice("Defeat enemies to summon 4 Metin Stones and destroy them.")

				d.set_regen_file("data/dungeon/dragon_lair/regen_boss.txt");

				Dungeon_Task_Helper.SetMaxCounter(4);
			end -- if

			if (2 == stage) then
				d.notice("Defeat Beran-Setaou.")

				d.spawn_mob(2493, 180, 174);

				Dungeon_Task_Helper.ClearCounter();
				Dungeon_Task_Helper.SetMaxCounter(1);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Dragon_Lair_Library.IsInDungeon() begin
			local Lv = Dragon_Lair_Library.GetDungeonStage();

			if (1 == Lv) then
				local Data = Dragon_Lair_Library.ReturnData();

				if (math.random(Data["Respawn_Metin_Stone_Math_Random"]) <= Data["Respawn_Metin_Stone_Chance"]) then
					if d.getf("Respawn_Metin_Stone") <= 3 then
						d.setf("Respawn_Metin_Stone", d.getf("Respawn_Metin_Stone") + 1);
					end -- if
				end -- if

				if (d.getf("Respawn_Metin_Stone") == 1 and d.getf("Respawn_Metin_Stone_Done_01") == 0) then
					d.setf("Respawn_Metin_Stone_Done_01", d.getf("Respawn_Metin_Stone_Done_01") + 1);
					d.spawn_mob(8031, 192, 183);
				elseif (d.getf("Respawn_Metin_Stone") == 2 and d.getf("Respawn_Metin_Stone_Done_02") == 0) then
					d.setf("Respawn_Metin_Stone_Done_02", d.getf("Respawn_Metin_Stone_Done_02") + 1);
					d.spawn_mob(8032, 192, 163);
				elseif (d.getf("Respawn_Metin_Stone") == 3 and d.getf("Respawn_Metin_Stone_Done_03") == 0) then
					d.setf("Respawn_Metin_Stone_Done_03", d.getf("Respawn_Metin_Stone_Done_03") + 1);
					d.spawn_mob(8033, 172, 163);
				elseif (d.getf("Respawn_Metin_Stone") == 4 and d.getf("Respawn_Metin_Stone_Done_04") == 0) then
					d.setf("Respawn_Metin_Stone_Done_04", d.getf("Respawn_Metin_Stone_Done_04") + 1);
					d.spawn_mob(8034, 172, 183);
				end -- if

				if (npc.get_race() >= 8031 and npc.get_race() <= 8034) then
					d.setf("Kill_Metin_Stone", d.getf("Kill_Metin_Stone") + 1);
					Dungeon_Task_Helper.IncCounter(1);
					if d.getf("Kill_Metin_Stone") == 4 then
						d.notice("You completed the task. The next task will be in 5 seconds.");
						timer("timer", 5);
						ClearDungeon(true);
					end -- if
				end -- if
			end -- if

			if (2 == Lv) then
				if (npc.get_race() == 2493) then
					local Data = Dragon_Lair_Library.ReturnData();

					local DungeonTime = get_time() - d.getf("DungeonTime");

					d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
					if party.is_party() then
						notice_all(string.format("The group founded by %s completed dungeon - Dragon Lair in %s.", pc.name, Get_Time_Format(DungeonTime)))
					else
						notice_all(string.format("Player %s completed dungeon - Dragon Lair in %s.", pc.name, Get_Time_Format(DungeonTime)))
					end -- if

					timer("ExitDung", 30);
					ClearDungeon(true);
					Dungeon_Task_Helper.IncCounter(1);
					d.finish();
				end -- if
			end -- if
		end -- when

		when ExitDung.timer with Dragon_Lair_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Dragon Lair.")
			d.exit_all();
		end -- when

		when timer.timer with Dragon_Lair_Library.IsInDungeon() begin
			local Lv = Dragon_Lair_Library.GetDungeonStage();

			if Lv == 1 then
				Dragon_Lair.Prepare(2);
			end -- if
		end -- when
	end -- state
end -- quest
