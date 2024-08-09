 quest Guild_Building_Alter_of_Power begin
	state start begin
		when 20077.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jestem Yaholo, Stra�nik O�tarza Mocy.")
			say("Budynek ten umo�liwia posiadanie wi�kszej ilo�ci")
			say("cz�onk�w w gildii.")
			say("Wraz ze wzrostem pot�gi gildii, mo�esz")
			say("rozbudowywa� O�tarz Mocy i w ten spos�b przyj�� ")
			say("wi�cej cz�onk�w do gildii.")
			if pc.getqf("build_level") == 0 then
				pc.setqf("build_level", guild.level(pc.get_guild()))
			end -- if
			wait()
			say("Hmm... Twoja gildia...")
			say("")
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Najwidoczniej sta�a si� pot�niejsza.")
				say("Chcesz zast�pi� obecny O�tarz Mocy wi�kszym")
				say("O�tarzem? W tym celu potrzebujesz nast�puj�ce")
				say("rzeczy:")
				say_reward("25 milion�w Yang")
				say_reward("10 Kamieni W�gielnych")
				say_reward("15 Pni")
				say_reward("10 Dykt")
				say("")
				local s = select("Zast�p O�tarz Mocy", "Nie zast�puj O�tarza Mocy")
				if s == 1 then
					if pc.count_item(90010) >= 10 and pc.count_item(90012) >= 15 and pc.count_item(90011) >= 10 and pc.get_gold() >= 25000000 then
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Dobrze. Zast�pi� go nowym budynkiem.")
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
						say("Rozbudowa O�tarza nie jest tania. Potrzebuj� ")
						say("tylko spor� ilo�� materia��w budowlanych i Yang.")
						say("B�d� m�g� Ci pom�c, jak tylko mi je dostarczysz.")
						say("Przyjd� ponownie, jak wszystko uzbierasz!")
						say("")
					end -- if
				elseif s == 2 then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Jak uwa�asz. Po prostu wr�� p�niej.")
					say("")
				end -- if
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Uwa�am, �e powiniene� forsowa� rozw�j twej")
				say("gildii. Nie jest jeszcze wystarczaj�co silna na")
				say("nowy O�tarz.")
				say("")
			end -- if
		end -- when

		when 20078.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Je�eli poziom twojej gildii wzro�nie, b�dziesz")
			say("m�g� rozbudowa� O�tarz Mocy. Gdy ro�nie poziom")
			say("twojej gildii staje si� ona coraz silniejsza.")
			say("")
			wait()
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Hmm... Twoja gildia...")
			say("")
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				say("Oh, teraz jest o wiele silniejsza! Zamieni� ")
				say("O�tarz Mocy na najlepszy. Ponadto, potrzeba")
				say("nast�puj�cych materia��w:")
				say_reward("30 milion�w Yang")
				say_reward("15 Kamieni W�gielnych")
				say_reward("20 Pni")
				say_reward("20 Dykt")
				say("")
				local s = select("Zast�p O�tarz Mocy", "Nie zast�puj O�tarza Mocy")
				if s == 1 then
					if pc.count_item(90010) >= 15 and pc.count_item(90012) >= 20 and pc.count_item(90011) >= 15 and pc.get_gold() >= 30000000 then
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Dobrze, zast�pi� O�tarz now� budowl�. W ten")
						say("spos�b twoja gildia b�dzie dysponowa� najlepszym")
						say("O�tarzem. Gratuluj�!")
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
						say("Rozbudowa O�tarza nie jest tania. Potrzebuj� ")
						say("tylko spor� ilo�� materia��w budowlanych i Yang.")
						say("B�d� m�g� Ci pom�c, jak tylko mi je dostarczysz.")
						say("Przyjd� ponownie, jak wszystko uzbierasz!")
						say("")
					end -- if
				elseif s == 2 then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Jak uwa�asz. Po prostu wr�� p�niej.")
					say("")
				end -- if
			end -- if
		end -- when

		when 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Nic wi�cej dla Ciebie zrobi� nie mog�. Twoja")
			say("gildia dysponuje ju� najlepszym O�tarzem Mocy.")
			say("")
		end -- when

		when 20077.click or 20078.click or 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master()!= true begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("O�tarz Mocy pozwala na posiadanie wi�kszej ilo�ci")
			say("cz�onk�w w gildii.")
			say("")
		end -- when
	end -- state
end -- quest
