quest Ship_Defense begin
	state start begin
		when 20395.chat."(Lv. 110) Ship Defense" begin
			local Data = Ship_Defense_Library.ReturnData();
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
			say_reward("Welcome to the entrance to the Ship Defense.")
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
			say_reward("Do you want to enter the Ship Defense?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Ship_Defense_Library.CheckRequire()) then
					Ship_Defense_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 20395.chat."(Lv. 110) Ship Defense - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return;
			end -- if
		end -- when

		when login with (Ship_Defense_Library.IsInDungeon()) begin
			local Data = Ship_Defense_Library.ReturnData();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			if (TimeData["IsRequire"]) then
				clear_server_timer("Ship_Defense_Time_Out", get_server_timer_arg());
				server_timer("Ship_Defense_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			Ship_Defense_Library.SetWaitTime();
			if not party.is_party() then
				d.setf("DungeonTime", get_time());
			end -- if
		end -- when

		when Ship_Defense_Library.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Ship Defense.");
				d.exit_all();
			end -- if
		end -- when

		when kill with npc.is_pc() == false and (Ship_Defense_Library.IsInDungeon()) begin
			if (npc.get_race() == 3965) then
				local Data = Ship_Defense_Library.ReturnData();

				local DungeonTime = get_time() - d.getf("DungeonTime");

				d.notice(string.format("In %s seconds you will be teleported to the entrance.", 30));
				if party.is_party() then
					notice_all(string.format("The group founded by %s completed dungeon - Ship Defense in %s.", pc.name, Get_Time_Format(DungeonTime)));
				else
					notice_all(string.format("Player %s completed dungeon - Ship Defense in %s.", pc.name, Get_Time_Format(DungeonTime)));
				end -- if

				d.finish();
			end -- if
		end -- when
	end -- state
end -- quest
