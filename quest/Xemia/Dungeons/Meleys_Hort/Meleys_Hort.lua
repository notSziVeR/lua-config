quest Meleys_Hort begin
	state start begin
		when 20394.chat."Schronienie Meley" begin
			local Data = Meleys_Hort_Library.ReturnData();
			local LevelRequire = Data["LevelRequire"];
			local GroupRequire = Data["GroupRequire"];
			local ItemRequire = Data["ItemRequire"];
			local TimeData = Data["TimeData"]["TimeToCompleteData"];
			local map_index = 320
			local d_status = sdd.check_status()

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say_reward("Witamy w wejœciu do Schronienie Meley!")
			say("")
			say("Mo¿liwoœæ wejœcia:|cFF009900 Solo/Grupa")
			if (pc.get_level() < LevelRequire["MinimumLevel"]) then
				say(string.format("Minimalny Poziom:|cFFFF0000 %d", LevelRequire["MinimumLevel"]))
			else
				say(string.format("Minimalny Poziom:|cFF009900 %d", LevelRequire["MinimumLevel"]))
			end -- if
			if (pc.get_level() > LevelRequire["MaximumLevel"]) then
				say(string.format("Maksymalny Poziom:|cFFFF0000 %d", LevelRequire["MaximumLevel"]))
			else
				say(string.format("Maksymalny Poziom:|cFF009900 %d", LevelRequire["MaximumLevel"]))
			end -- if
			if pc.countitem(ItemRequire["ItemVnum"]) >= 1 then
				say(string.format("Przepustka: " .. item_name(ItemRequire["ItemVnum"]) .. " (|cFF009900%d|r/|cFF009900%d|r)", ItemRequire["ItemCount"], pc.countitem(ItemRequire["ItemVnum"])))
			else
				say(string.format("Przepustka: " .. item_name(ItemRequire["ItemVnum"]) .. " (|cFF009900%d|r/|cFFFF0000%d|r)", ItemRequire["ItemCount"], pc.countitem(ItemRequire["ItemVnum"])))
			end -- if
			if party.is_party() then
				say("Ka¿dy z grupy potrzebuje przepustki w ekwipunku.")
			end -- if
			if party.is_party() then
				if (party.get_near_count() < 1) then
					say(string.format("Grupa:|cFFFF0000 %d|r/|cFF009900%d", party.get_near_count(), GroupRequire["MaximumPartyMemebers"]))
				else
					say(string.format("Grupa:|cFF009900 %d|r/|cFF009900%d", party.get_near_count(), GroupRequire["MaximumPartyMemebers"]))
				end -- if
			else
				say("Grupa:|cFF009900 Brak Grupy")
			end -- if
			say("")
			say_reward("Chcesz wejœæ do Schronienie Meley?")
			say("")
			if (select("Tak, chcê ", "Nie, nie chcê ") == 1) then
				if (Meleys_Hort_Library.CheckRequire()) then
					-- Meleys_Hort_Library.WarpToDungeon();
				end -- if
			end -- if
		end -- when
	end -- state
end -- quest
