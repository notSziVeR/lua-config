quest Guild_Building begin
	state start begin
		when 20040.click begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jestem Zarz�dc� tego terenu i odpowiadam za jego")
			say("sprzeda�. Zanim potwory opanowa�y l�d na")
			say("kontynencie, nie brakowa�o nam ziemi i wszyscy")
			say("ludzie byli zadowoleni. Teraz sprzedaj� ziemie")
			say("tylko pod tereny dla gildii. Robi� interesy tylko")
			say("z przyw�dcami gildii.")
			say("Czy chcesz kupi� ten teren?")
			say("")
			local s = select("Tak", "Nie")
			if s == 1 then
				if not pc.is_guild_master() then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Ju� Ci m�wi�em, nie mog� sprzedawa� teren�w")
					say("ka�demu. Mam nadziej�, �e mnie rozumiesz...")
					say("")
				elseif building.has_land(pc.get_guild()) then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Gildia, kt�ra posiada ju� sw�j teren nie mo�e")
					say("kupi� nast�pnego.")
					say("")
			else
				local land_id = building.get_land_id(pc.get_map_index(), pc.get_x() * 100, pc.get_y() * 100)
				if land_id == 0 then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Wyst�pi� b��d podczas operacji.")
					say("")
				else
					local price, owner, guild_level_limit = building.get_land_info(land_id)
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Aby wykupi� t� dzia�k�, poziom gildii musi")
					say(string.format("wynosi� powy�ej %s.", guild_level_limit))
					say(string.format("Cena wynosi %s Yang.", price))
					say("")
					if guild.level(pc.get_guild()) < guild_level_limit then
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Twoja gildia nie osi�gn�a jeszcze odpowiedniego")
						say("poziomu. Przykro mi.")
						say("")
					else
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Chcesz kupi� t� ziemi�?")
						say("")
						s = select("Tak", "Nie")
						if s == 1 then
						local price, owner, guild_level_limit = building.get_land_info(land_id)
							if owner != 0 then
								text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
								say("_____________________________________________________")
								say("Ten teren zosta� ju� sprzedany innej gildii.")
								say("Przykro mi.")
								say("")
							elseif pc.gold < price then
								text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
								say("_____________________________________________________")
								say("Jestem tylko Agentem L�dowym.")
								say("Nie mog� obni�y� ceny.")
								say("Prosz�, przynie� mi wi�cej Yang.")
								say("")
							else
								pc.changegold(-price)
								building.set_land_owner(land_id, pc.get_guild())
								-- TODO
								--notice(string.format("Gildia naby�a teren!", guild.name(pc.get_guild())), notice)
							end -- if
						else
							text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
							say("_____________________________________________________")
							say("Wr��, gdy zdecydujesz co chcesz zrobi�...")
							say("Kto pierwszy ten lepszy.")
							say("")
						end -- if
					end -- if
				end -- if
				end -- if
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Wr��, gdy zdecydujesz co chcesz zrobi�...")
				say("Kto pierwszy ten lepszy.")
				say("")
			end -- if
		end -- when
	end -- state
end -- quest
