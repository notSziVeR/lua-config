quest Red_Dragon_Fortress begin
	state start begin
		when 20394.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when 20394.chat."(Lv. 95) Red Dragon Fortress" begin
			local Data = Red_Dragon_Fortress_Library.ReturnData();
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
			say_reward("Welcome to the entrance to the Red Dragon Fortress.")
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
			say_reward("Do you want to enter the Red Dragon Fortress?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				if (Red_Dragon_Fortress_Library.CheckRequire()) then
					Red_Dragon_Fortress_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when

		when 20394.chat."(Lv. 95) Red Dragon Fortress - Return" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Do you want to return to the dungeon?")
			say("")
			if (select("Want", "Don't Want") == 1) then
				return;
			end -- if
		end -- when

		when login with (Red_Dragon_Fortress_Library.IsInDungeon()) begin
			local Data = Red_Dragon_Fortress_Library.ReturnData();
			local Lv = Red_Dragon_Fortress_Library.GetDungeonStage();
			local OutsideData = Data["TeleportData"]["OutsideDungeon"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];

			d.set_warp_location(OutsideData["InsideMapIndex"], OutsideData["EnterPositions"]["x"], OutsideData["EnterPositions"]["y"]);

			if (TimeData["IsRequire"]) then
				clear_server_timer("Red_Dragon_Fortress_Time_Out", get_server_timer_arg());
				server_timer("Red_Dragon_Fortress_Time_Out", TimeData["TimeToComplete"], d.get_map_index());
			end -- if

			if (Lv == 0) then
				Red_Dragon_Fortress_Library.SetWaitTime();
				if not party.is_party() then
					d.setf("DungeonTime", get_time());
				end -- if
				Red_Dragon_Fortress.Prepare(1);
			end -- if
		end -- when

		when Red_Dragon_Fortress_Time_Out.server_timer begin
			if (d.select(get_server_timer_arg())) then
				d.notice("The time has expired, you will be teleported out the Red Dragon Fortress.");
				d.exit_all();
			end -- if
		end -- when

		function Prepare(Stage)
			local Data = Red_Dragon_Fortress_Library.ReturnData();

			if (Red_Dragon_Fortress_Library.GetDungeonStage() == Stage) then
				return;
			end -- if

			if (is_test_server()) or pc.is_gm() then
				d.notice("[Debug]: Currend dungeon stage is " .. Stage .. ".");
			end -- if

			Red_Dragon_Fortress_Library.SetNewDungeonStage();

			if (1 == Stage) then
				d.notice(string.format("Udaj siê do %s, aby da³ ci zadania, aby udaæ sie do pokoju %s.", mob_name(20385), mob_name(6091)));

				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_flamenpc.txt");
				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_1.txt");
			end -- if

			if (2 == Stage) then
				d.notice(string.format("Zabijaj potwory, dopóki nie zdobêdziesz %s.", item_name(30351)));

				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_2.txt");
				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/fd_a.txt");
			end -- if

			if (3 == Stage) then
				d.notice(string.format("Zdob¹dŸ i znajdz prawid³owy %s z potworów i otwórz %s.", item_name(30329), mob_name(20386)));

				d.spawn_mob(20386, 190, 356);

				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_3.txt");
				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/fd_b.txt");
			end -- if

			if (4 == Stage) then
				d.notice(string.format("Zniscz prawid³owego %s, aby otrzymaæ %s.", mob_name(6009), item_name(30351)));

				local minibossPosition = {
					{253, 244}, {284, 207}, {251, 196}, {315, 222}, {290, 181}
				};

				for index = 1, table.getn(minibossPosition) - 1, 1 do
					local randomNumber = math.random(table.getn(minibossPosition));
					d.spawn_mob(6009, minibossPosition[randomNumber][1], minibossPosition[randomNumber][2]);
					table.remove(minibossPosition, randomNumber);
				end -- for

				local realminibossVID = d.spawn_mob(6009, minibossPosition[1][1], minibossPosition[1][2]);
				d.set_unique("real_miniboss", realminibossVID);

				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_4.txt");
			end -- if

			if (5 == Stage) then
				d.notice(string.format("Pokonaj %s.", mob_name(6051)));

				d.spawn_mob(6051, 480, 170);

				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_5.txt");
				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/fd_d.txt");
			end -- if

			if (6 == Stage) then
				d.notice(string.format("Zabij potwory, aby upuœciæ %s, aby odblokowaæ wszystkie 7 %s.", item_name(30330), mob_name(20386)));

				d.setf("steal_count", 8);

				d.spawn_mob(20386, 500, 354);
				d.spawn_mob(20386, 511, 336);
				d.spawn_mob(20386, 525, 349);
				d.spawn_mob(20386, 521, 365);
				d.spawn_mob(20386, 503, 372);
				d.spawn_mob(20386, 486, 365);
				d.spawn_mob(20386, 486, 345);

				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_6.txt");
				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/fd_e.txt");
			end -- if

			if (7 == Stage) then
				d.notice(string.format("Zniszcz %s.", mob_name(8057)));

				d.spawn_mob(8057, 502, 487);

				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_flamenpc.txt");
				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/fd_f.txt");
			end -- if

			if (8 == Stage) then
				d.notice(string.format("Pokonaj %s.", mob_name(6091)));

				d.spawn_mob(6091, 686, 637);

				local secondFloorPos = Data["1th_teleport_coords"];
				d.jump_all(secondFloorPos["x"], secondFloorPos["y"]);
			end -- if
		end -- function

		when kill with npc.is_pc() == false and Red_Dragon_Fortress_Library.IsInDungeon() begin
			local Lv = Red_Dragon_Fortress_Library.GetDungeonStage();

			if (1 == Lv) then
			end -- if

			if (2 == Lv) then
				local i = number(1, 200);
				if i == 1 then
					d.notice(string.format("%s zdobyty! Podnieœ go i przerzuæ na odpowiedni %s.", item_name(30351), mob_name(20387)));
					game.drop_item(30351, 1);
					ClearDungeon(true);
					d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_2.txt");
				end -- if
			end -- if

			if (3 == Lv) then
				local i = number(1, 200);
				if i == 1 then
					game.drop_item(30329, 1);
				end -- if
			end -- if

			if (4 == Lv) then
				local npcVID = npc.get_vid();
				local realminibossVID = d.get_unique_vid("real_miniboss");

				if (npc.get_race() == 6009) then
					if (npcVID == realminibossVID) then
						d.notice(string.format("Pokona³eœ prawid³owego %s.", mob_name(6009)));
						d.notice(string.format("%s zdobyty! Podnieœ go i przerzuæ na odpowiedni %s.", item_name(30351), mob_name(20387)));
						game.drop_item(30351, 1);
						ClearDungeon(true);
						d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_4.txt");
					else
						d.notice(string.format("Pokona³eœ nieprawid³owego %s.", mob_name(6009)))
					end -- if
				end -- if
			end -- if

			if (5 == Lv) then
				if (npc.get_race() == 6051) then
					d.notice(string.format("Pokona³eœ %s i zdoby³eœ %s. Podnieœ go i przerzuæ na odpowiedni %s.", mob_name(6051), item_name(30351), mob_name(20387)));
					game.drop_item(30351, 1);
					ClearDungeon(true);
					d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_5.txt");
				end -- if
			end -- if

			if (6 == Lv) then
				local i = number(1, 50);
				if i == 1 then
					game.drop_item(30330, 1);
				end -- if
			end -- if

			if (7 == Lv) then
				if (npc.get_race() == 8057) then
					timer("timer", 5);
					d.notice("Pokona³eœ metina.");
					d.notice(string.format("Uda³o ci siê ukoñczyæ zadanie. Nastêpne zadanie bêdzie za %s sekund.", 5));
					ClearDungeon(true);
				end -- if
			end -- if

			if (8 == Lv) then
				if (npc.get_race() == 6091) then
					d.notice(string.format("Za %s sekund zostaniesz wyrzucony z dungeonu.", 30));
					
					local DungeonTime = get_time() - d.getf("DungeonTime");
					
					notice_all(string.format("Twierdza Czerwonego Smoka zosta³a ukoñczona przez %s w %s.", pc.name, Get_Time_Format(DungeonTime)));

					timer("ExitDung", 30);
					ClearDungeon(true);
					d.finish();
				end -- if
			end -- if
		end -- when

		when 20385.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 1) begin
			npc.purge();

			game.drop_item(30351, 1);
			d.notice(string.format("Otrzyma³eœ %s, przerzuæ %s na odpowiedni %s.", item_name(30351), item_name(30351), mob_name(20387)));
		end -- when

		when 20387.take or 20387.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 1) begin
			if item.vnum == 30351 then
				local deleteItems = {30351};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				d.notice(string.format("%s zosta³ zniszczony.", mob_name(20387)));
				ClearDungeon(true);
				timer("timer", 0)
			end -- if
		end -- when

		when 20387.take or 20387.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 2) begin
			if item.vnum == 30351 then
				local deleteItems = {30351};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				d.notice(string.format("%s zosta³ zniszczony.", mob_name(20387)));
				ClearDungeon(true);
				timer("timer", 0);
			end -- if
		end -- when

		when 20386.take or 20386.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 3) begin
			if item.vnum == 30329 then
				local deleteItems = {30329};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				d.notice(string.format("%s zosta³ zniszczony.", mob_name(20386)));
				d.notice(string.format("Otrzyma³eœ %s, przerzuæ %s na odpowiedni %s.", item_name(30351), item_name(30351), mob_name(20387)));

				ClearDungeon(true);
				d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_3.txt");
				game.drop_item(30351, 1);
			end -- if
		end -- when

		when 20387.take or 20387.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 3) begin
			if item.vnum == 30351 then
				local deleteItems = {30351};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				d.notice(string.format("%s zosta³ zniszczony.", mob_name(20387)));
				ClearDungeon(true);
				timer("timer", 0);
			end -- if
		end -- when

		when 20387.take or 20387.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 4) begin
			if item.vnum == 30351 then
				local deleteItems = {30351};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				d.notice(string.format("%s zosta³ zniszczony.", mob_name(20387)));
				ClearDungeon(true);
				timer("timer", 0);
			end -- if
		end -- when

		when 20387.take or 20387.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 5) begin
			if item.vnum == 30351 then
				local deleteItems = {30351};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				d.notice(string.format("%s zosta³ zniszczony.", mob_name(20387)));
				ClearDungeon(true);
				timer("timer", 0);
			end -- if
		end -- when

		when 20386.take or 20386.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 6) begin
			if item.vnum == 30330 then
				d.setf("steal_count", d.getf("steal_count") - 1)
				local deleteItems = {30330};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				if d.getf("steal_count") == 7 then
					d.notice("Otwarta Pieczêæ! Pozosta³o: " .. (d.getf("steal_count") - 1) .. ".");
				elseif d.getf("steal_count") == 6 then
					d.notice("Otwarta Pieczêæ! Pozosta³o: " .. (d.getf("steal_count") - 1) .. ".");
				elseif d.getf("steal_count") == 5 then
					d.notice("Otwarta Pieczêæ! Pozosta³o: " .. (d.getf("steal_count") - 1) .. ".");
				elseif d.getf("steal_count") == 4 then
					d.notice("Otwarta Pieczêæ! Pozosta³o: " .. (d.getf("steal_count") - 1) .. ".");
				elseif d.getf("steal_count") == 3 then
					d.notice("Otwarta Pieczêæ! Pozosta³o: " .. (d.getf("steal_count") - 1) .. ".");
				elseif d.getf("steal_count") == 2 then
					d.notice("Otwarta Pieczêæ! Pozosta³o: " .. (d.getf("steal_count") - 1) .. ".");
				elseif d.getf("steal_count") == 1 then
					d.setf("steal_count", 0);
					d.notice(string.format("%s zosta³ zniszczony.", mob_name(20386)));
					d.notice(string.format("Otrzyma³eœ %s, przerzuæ %s na odpowiedni %s.", item_name(30351), item_name(30351), mob_name(20387)));
					ClearDungeon(true);
					game.drop_item(30351, 1);
					d.set_regen_file("data/dungeon/Red_Dragon_Fortress/blazingpurgatory_gate_6.txt");
				end -- if
			end -- if
		end -- when

		when 20387.take or 20387.click with (Red_Dragon_Fortress_Library.IsInDungeon() and Red_Dragon_Fortress_Library.GetDungeonStage() == 6) begin
			if item.vnum == 30351 then
				local deleteItems = {30351};

				for index in deleteItems do
					pc.remove_item(deleteItems[index], 1);
				end -- for

				npc.purge();

				d.notice(string.format("%s zosta³ zniszczony.", mob_name(20387)));
				ClearDungeon(true);
				timer("timer", 0);
			end -- if
		end -- when

		when ExitDung.timer with Red_Dragon_Fortress_Library.IsInDungeon() begin
			d.notice("The time has expired, you will be teleported out the Red Dragon Fortress.")
			d.exit_all()
		end -- when

		when timer.timer with Red_Dragon_Fortress_Library.IsInDungeon() begin
			local Data = Red_Dragon_Fortress_Library.ReturnData();
			local Lv = Red_Dragon_Fortress_Library.GetDungeonStage();

			if Lv == 1 then
				Red_Dragon_Fortress.Prepare(2);
			end -- if

			if Lv == 2 then
				Red_Dragon_Fortress.Prepare(3);
			end -- if

			if Lv == 3 then
				Red_Dragon_Fortress.Prepare(4);
			end -- if

			if Lv == 4 then
				Red_Dragon_Fortress.Prepare(5);
			end -- if

			if Lv == 5 then
				Red_Dragon_Fortress.Prepare(6);
			end -- if

			if Lv == 6 then
				Red_Dragon_Fortress.Prepare(7);
			end -- if

			if Lv == 7 then
				Red_Dragon_Fortress.Prepare(8);
			end -- if
		end -- when
	end -- state
end -- quest
