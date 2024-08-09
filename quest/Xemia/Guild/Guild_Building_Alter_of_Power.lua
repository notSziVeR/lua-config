 quest Guild_Building_Alter_of_Power begin
	state start begin
		when 20077.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jestem Yaholo, Stra¿nik O³tarza Mocy.")
			say("Budynek ten umo¿liwia posiadanie wiêkszej iloœci")
			say("cz³onków w gildii.")
			say("Wraz ze wzrostem potêgi gildii, mo¿esz")
			say("rozbudowywaæ O³tarz Mocy i w ten sposób przyj¹æ ")
			say("wiêcej cz³onków do gildii.")
			if pc.getqf("build_level") == 0 then
				pc.setqf("build_level", guild.level(pc.get_guild()))
			end -- if
			wait()
			say("Hmm... Twoja gildia...")
			say("")
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Najwidoczniej sta³a siê potê¿niejsza.")
				say("Chcesz zast¹piæ obecny O³tarz Mocy wiêkszym")
				say("O³tarzem? W tym celu potrzebujesz nastêpuj¹ce")
				say("rzeczy:")
				say_reward("25 milionów Yang")
				say_reward("10 Kamieni Wêgielnych")
				say_reward("15 Pni")
				say_reward("10 Dykt")
				say("")
				local s = select("Zast¹p O³tarz Mocy", "Nie zastêpuj O³tarza Mocy")
				if s == 1 then
					if pc.count_item(90010) >= 10 and pc.count_item(90012) >= 15 and pc.count_item(90011) >= 10 and pc.get_gold() >= 25000000 then
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Dobrze. Zast¹piê go nowym budynkiem.")
						say("")
						building.reconstruct(14062)
						pc.setqf("build_level", guild.level(pc.get_guild()))
						char_log(0, "GUILD_BUILDING", "alter_of_power 14062 constructed")
						pc.change_gold(-25000000)
						pc.remove_item("90010", 10)
						pc.remove_item("90011", 10)
						pc.remove_item("90012", 15)
					else
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Rozbudowa O³tarza nie jest tania. Potrzebujê ")
						say("tylko spor¹ iloœæ materia³ów budowlanych i Yang.")
						say("Bêdê móg³ Ci pomóc, jak tylko mi je dostarczysz.")
						say("PrzyjdŸ ponownie, jak wszystko uzbierasz!")
						say("")
					end -- if
				elseif s == 2 then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Jak uwa¿asz. Po prostu wróæ póŸniej.")
					say("")
				end -- if
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Uwa¿am, ¿e powinieneœ forsowaæ rozwój twej")
				say("gildii. Nie jest jeszcze wystarczaj¹co silna na")
				say("nowy O³tarz.")
				say("")
			end -- if
		end -- when

		when 20078.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Je¿eli poziom twojej gildii wzroœnie, bêdziesz")
			say("móg³ rozbudowaæ O³tarz Mocy. Gdy roœnie poziom")
			say("twojej gildii staje siê ona coraz silniejsza.")
			say("")
			wait()
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Hmm... Twoja gildia...")
			say("")
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				say("Oh, teraz jest o wiele silniejsza! Zamieniê ")
				say("O³tarz Mocy na najlepszy. Ponadto, potrzeba")
				say("nastêpuj¹cych materia³ów:")
				say_reward("30 milionów Yang")
				say_reward("15 Kamieni Wêgielnych")
				say_reward("20 Pni")
				say_reward("20 Dykt")
				say("")
				local s = select("Zast¹p O³tarz Mocy", "Nie zastêpuj O³tarza Mocy")
				if s == 1 then
					if pc.count_item(90010) >= 15 and pc.count_item(90012) >= 20 and pc.count_item(90011) >= 15 and pc.get_gold() >= 30000000 then
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Dobrze, zast¹piê O³tarz now¹ budowl¹. W ten")
						say("sposób twoja gildia bêdzie dysponowaæ najlepszym")
						say("O³tarzem. Gratulujê!")
						say("")
						building.reconstruct(14063)
						pc.setqf("build_level", guild.level(pc.get_guild()))
						char_log(0, "GUILD_BUILDING", "alter_of_power 14063 constructed")
						pc.change_gold(-30000000)
						pc.remove_item("90010", 15)
						pc.remove_item("90011", 20)
						pc.remove_item("90012", 20)
					else
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Rozbudowa O³tarza nie jest tania. Potrzebujê ")
						say("tylko spor¹ iloœæ materia³ów budowlanych i Yang.")
						say("Bêdê móg³ Ci pomóc, jak tylko mi je dostarczysz.")
						say("PrzyjdŸ ponownie, jak wszystko uzbierasz!")
						say("")
					end -- if
				elseif s == 2 then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Jak uwa¿asz. Po prostu wróæ póŸniej.")
					say("")
				end -- if
			end -- if
		end -- when

		when 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Nic wiêcej dla Ciebie zrobiæ nie mogê. Twoja")
			say("gildia dysponuje ju¿ najlepszym O³tarzem Mocy.")
			say("")
		end -- when

		when 20077.click or 20078.click or 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master()!= true begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("O³tarz Mocy pozwala na posiadanie wiêkszej iloœci")
			say("cz³onków w gildii.")
			say("")
		end -- when
	end -- state
end -- quest
