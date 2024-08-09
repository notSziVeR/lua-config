quest Guild_Building_Melt begin
	state start begin
		function GetOreRefineCost(cost)
			if pc.empire != npc.empire then
			return 3 * cost
			end -- if
			if pc.get_guild() == npc.get_guild() then
			return cost * 0.9
			end -- if
			return cost
		end -- function

		function GetOreRefineGoodPct()
			return 60
		end -- function

		function GetOreRefineBadPct()
			return 30
		end -- function

		function GetMyRefineNum(race)
			if 20170 == race then
				return 50614
			end -- if

			if 20171 == race then
				return 50619
			end -- if
			return race - 20060 + 50601
		end -- function

		function IsRefinableRawOre(vnum)
			return vnum >= 50601 and vnum <= 50619
		end -- function

		function DoRefineDiamond(pct)
			local from_postfix
			local from_name = item_name(item.vnum)
			local to_vnum = item.vnum + 20
			local to_name = item_name(to_vnum)
			local to_postfix

			say("Ze 100 Diamentowych Kamieni mo¿na wykonaæ Diament.")

			if item.count >= 100 then
			say(string.format("Szansa na powodzenie to %s.", pct))
			say(string.format("Potrzebujesz %s Yang.", Guild_Building_Melt.GetOreRefineCost(10000)))
			say("Czy chcesz spróbowaæ?")
			local s = select("Tak", "Nie")
			if s == 1 then
				if pc.get_gold() < Guild_Building_Melt.GetOreRefineCost(10000) then
					say("Potrzebujesz wiêcej Yang!")
					return
				end -- if

				if pc.diamond_refine(10000, pct) then
					say("Gratulacje! Uszlachetnienie zakoñczone sukcesem.")
					say("Teraz posiadasz:")
					say_item(to_name, to_vnum, "")
				else
					say("Uszlachetnienie nie powiod³o siê...")
				end -- if
			end -- if
			else
				say(string.format("Nie posiadasz 100 %s.", from_name))
			end -- if
		end -- function

		function DoRefine(pct)
			local from_postfix
			local from_name = item_name(item.vnum)
			local to_vnum = item.vnum + 20
			local to_name = item_name(to_vnum)
			local to_postfix

			-- IDK
			say(string.format(gameforge.guild_building_melt._70_say, from_name, to_name))
			if item.count >= 100 then
			say(string.format("Szansa na powodzenie to %s.", pct))
			say(string.format("Potrzebujesz %s Yang.", Guild_Building_Melt.GetOreRefineCost(3000)))
			say("Czy chcesz spróbowaæ?")
			local s = select("Tak", "Nie")
			if s == 1 then
				if pc.get_gold() < Guild_Building_Melt.GetOreRefineCost(3000) then
					say("Potrzebujesz wiêcej Yang!")
					return
				end -- if

				local selected_item_cell = select_item()
				if selected_item_cell == 0 then
					say("Nie jestem w stanie wytworzyæ przedmiotu bez")
					say("Kamienia Duszy.")
					return
				end -- if
				local old_item = item.get_id()

				if (not item.select_cell(selected_item_cell)) or item.vnum < 28000 or item.vnum >= 28300 then
					say("To nie jest niezbêdny przedmiot...")
					return
				end -- if

				item. select(old_item, old_item)

				if pc.ore_refine(3000, pct, selected_item_cell) then
					say("Gratulacje! Uszlachetnienie zakoñczone sukcesem.")
					say("Teraz posiadasz:")
					say_item(to_name, to_vnum, "")
				else
					say("Uszlachetnienie nie powiod³o siê...")
				end -- if
			end -- if
			else
			say(string.format("Nie posiadasz 100 %s.", from_name))
			end -- if
		end -- function

		when 20060.take or 20061.take or 20062.take or 20063.take or 20064.take or 20065.take or 20066.take or 20067.take or 20068.take or 20069.take or 20170.take or 20070.take or 20071.take or 20072.take with Guild_Building_Melt.GetMyRefineNum(npc.race) == item.vnum begin
			if item.vnum == 50601 then
				Guild_Building_Melt.DoRefineDiamond(Guild_Building_Melt.GetOreRefineGoodPct())
			else
				Guild_Building_Melt.DoRefine(Guild_Building_Melt.GetOreRefineGoodPct())
			end -- if
		end -- when

		when 20060.take or 20061.take or 20062.take or 20063.take or 20064.take or 20065.take or 20066.take or 20067.take or 20068.take or 20069.take or 20070.take or 20170.take or 20071.take or 20072.take with Guild_Building_Melt.IsRefinableRawOre(item.vnum) and Guild_Building_Melt.GetMyRefineNum(npc.race) != item.vnum begin
			if item.vnum == 50601 then
				Guild_Building_Melt.DoRefineDiamond(Guild_Building_Melt.GetOreRefineBadPct())
			else
				Guild_Building_Melt.DoRefine(Guild_Building_Melt.GetOreRefineBadPct())
			end -- if
		end -- when

		when 20060.click or 20061.click or 20062.click or 20063.click or 20064.click or 20065.click or 20066.click or 20067.click or 20068.click or 20069.click or 20070.click or 20071.click or 20170.click or 20171.click or 20072.click with npc.get_guild() == pc.get_guild() and pc.isguildmaster() begin
			say("ZA 3.000.000 Yang mo¿esz zatrudniæ innego")
			say("Alchemika.")
			if pc.get_gold() < 3000000 then
				say("Nie posiadasz 3.000.000 Yang.")
			else
				say("Wybierz specjalizacjê, aby dokonaæ zamiany:")

			local sel = 0
			local timetable1 = {"Diamenty", 
								"Drewno",
								"MiedŸ ",
								"Srebro",
								"Z³oto",
								"Jadeit",
								"Dalej", 
								"Zamknij"}
			local valuetable1 = {14043, 14045, 14046, 14047, 14048, 14049, 0, -1}

			local timetable2 = {"Ebonit",
								"Per³y",
								"Bia³e Z³oto",
								"Kryszta³ ",
								"Ametyst",
								"Niebiañskie £zy",
								"Dalej", 
								"Zamknij"}
			local valuetable2 = {14050, 14051, 14052, 14053, 14054, 14055, 0, -1}
					
			local timetable3 = {"Ebonit",
								"Per³y",
								"Bia³e Z³oto",
								"Kryszta³ ",
								"Ametyst",
								"Dalej", 
								"Zamknij"}
			local valuetable3 = {14056, 14057, 14058, 14059, 14060, 14055, 0, -1}

			repeat
				local s = select_table(timetable1)
				sel = valuetable1[s]
				if sel == 0 then
					local s = select_table(timetable2)
					sel = valuetable2[s]
				end -- if
			until sel != 0

			if sel != -1 then
				npc_num = sel + 20060 - 14043
				if npc_num == npc.get_race() then
					say("Ta specjalizacja jest ju¿ aktywna.")
				else
					pc.changegold(-3000000)
					building.reconstruct(sel)
				end -- if
			end -- if
			end -- if
		end -- when
	end -- state
end -- quest

