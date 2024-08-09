quest Guild_Building begin
	state start begin
		when 20040.click begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jestem Zarz¹dc¹ tego terenu i odpowiadam za jego")
			say("sprzeda¿. Zanim potwory opanowa³y l¹d na")
			say("kontynencie, nie brakowa³o nam ziemi i wszyscy")
			say("ludzie byli zadowoleni. Teraz sprzedajê ziemie")
			say("tylko pod tereny dla gildii. Robiê interesy tylko")
			say("z przywódcami gildii.")
			say("Czy chcesz kupiæ ten teren?")
			say("")
			local s = select("Tak", "Nie")
			if s == 1 then
				if not pc.is_guild_master() then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Ju¿ Ci mówi³em, nie mogê sprzedawaæ terenów")
					say("ka¿demu. Mam nadziejê, ¿e mnie rozumiesz...")
					say("")
				elseif building.has_land(pc.get_guild()) then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Gildia, która posiada ju¿ swój teren nie mo¿e")
					say("kupiæ nastêpnego.")
					say("")
			else
				local land_id = building.get_land_id(pc.get_map_index(), pc.get_x() * 100, pc.get_y() * 100)
				if land_id == 0 then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Wyst¹pi³ b³¹d podczas operacji.")
					say("")
				else
					local price, owner, guild_level_limit = building.get_land_info(land_id)
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Aby wykupiæ t¹ dzia³kê, poziom gildii musi")
					say(string.format("wynosiæ powy¿ej %s.", guild_level_limit))
					say(string.format("Cena wynosi %s Yang.", price))
					say("")
					if guild.level(pc.get_guild()) < guild_level_limit then
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Twoja gildia nie osi¹gnê³a jeszcze odpowiedniego")
						say("poziomu. Przykro mi.")
						say("")
					else
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Chcesz kupiæ t¹ ziemiê?")
						say("")
						s = select("Tak", "Nie")
						if s == 1 then
						local price, owner, guild_level_limit = building.get_land_info(land_id)
							if owner != 0 then
								text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
								say("_____________________________________________________")
								say("Ten teren zosta³ ju¿ sprzedany innej gildii.")
								say("Przykro mi.")
								say("")
							elseif pc.gold < price then
								text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
								say("_____________________________________________________")
								say("Jestem tylko Agentem L¹dowym.")
								say("Nie mogê obni¿yæ ceny.")
								say("Proszê, przynieœ mi wiêcej Yang.")
								say("")
							else
								pc.changegold(-price)
								building.set_land_owner(land_id, pc.get_guild())
								-- TODO
								--notice(string.format("Gildia naby³a teren!", guild.name(pc.get_guild())), notice)
							end -- if
						else
							text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
							say("_____________________________________________________")
							say("Wróæ, gdy zdecydujesz co chcesz zrobiæ...")
							say("Kto pierwszy ten lepszy.")
							say("")
						end -- if
					end -- if
				end -- if
				end -- if
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Wróæ, gdy zdecydujesz co chcesz zrobiæ...")
				say("Kto pierwszy ten lepszy.")
				say("")
			end -- if
		end -- when
	end -- state
end -- quest
