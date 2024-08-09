quest Erebos begin
	state start begin
		when 20412.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when 20412.chat."(Lv. 100) Erebos" begin
			local Data = Erebos_Library.ReturnData();
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
			say_reward("Welcome to the entrance to the Erebos.")
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
			say_reward("Do you want to enter the Erebos?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Erebos_Library.CheckRequire()) then
					Erebos_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 20412.chat."(Lv. 100) Erebos - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return;
			end -- if
		end -- when

		when login with (Erebos_Library.IsInDungeon()) begin
			local Data = Erebos_Library.ReturnData();
			local Lv = Erebos_Library.GetDungeonStage();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (TimeData["IsRequire"]) then
				clear_server_timer("Erebos_Time_Out", get_server_timer_arg());
				server_timer("Erebos_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			if (Lv == 0) then
				Erebos_Library.SetWaitTime();
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Erebos.Prepare(1);
			end -- if
		end -- when

		when Erebos_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Erebos.");
				d.exit_all();
			end -- if
		end -- when

		function Prepare(stage)
			local Data = Erebos_Library.ReturnData();

			if (Erebos_Library.GetDungeonStage() == stage) then
				return;
			end -- if

			Erebos_Library.SetNewDungeonStage();

			if is_test_server() or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. stage .. ".");
			end -- if

			if (1 == stage) then
				d.notice("Defeat Bagjanamu.");

				d.spawn_mob(6408, 68, 941);
			end -- if

			if (2 == stage) then
				d.notice("Defeat Jotun Thrym.");

				d.spawn_mob(6192, 68, 941);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Erebos_Library.IsInDungeon() begin
			local Lv = Erebos_Library.GetDungeonStage();

			if (1 == Lv) then
				if (npc.get_race() == 6408) then
					timer("timer", 0);
				end -- if
			end -- if

			if (2 == Lv) then
				if (npc.get_race() == 6192) then
					local Data = Erebos_Library.ReturnData();

					local DungeonTime = get_time() - d.getf("DungeonTime");

					d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
					if party.is_party() then
						notice_all(string.format("The group founded by %s completed dungeon - Erebos in %s.", pc.name, Get_Time_Format(DungeonTime)));
					else
						notice_all(string.format("Player %s completed dungeon - Erebos in %s.", pc.name, Get_Time_Format(DungeonTime)));
					end -- if

					timer("ExitDung", 30);
					ClearDungeon(true);
					d.finish();
				end -- if
			end -- if
		end -- when

		when ExitDung.timer with Erebos_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Erebos.");
			d.exit_all();
		end -- when

		when timer.timer with Erebos_Library.IsInDungeon() begin
			local Lv = Erebos_Library.GetDungeonStage();

			if Lv == 1 then
				Erebos.Prepare(2);
			end -- if
		end -- when
	end -- state
end -- quest
