quest Guild_War_Observer begin
	state start begin
		when guild_war_observer1.chat."Poka¿ Listê Bitew Gildii" begin
			local g = guild.get_warp_war_list() -- return format {{1,2}, {3,4}}
			local gname_table = {}
			table.foreachi(g,
				function(n, p) 
				gname_table[n] = guild.get_name(p[1]) .. " vs " .. guild.get_name(p[2])
			end) -- if

			if table.getn(g) == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("W tej chwili nie ma ¿adnych wojen.")
				say("")
			else
				gname_table[table.getn(g)+1] = "Kontynuuj"
				say("Obecnie odbywaj¹ siê nastêpuj¹ce Wojny Gildii:")
				say("Jeœli chcesz byæ obserwatorem, wybierz któr¹œ z")
				say("pozycji.")
				local s = select_table(gname_table)
				if s != table.getn(gname_table) then
					pc.warp_to_guild_war_observer_position(g[s][1], g[s][2])
				end -- if
			end -- if
		end -- when

		when guild_war_observer2.chat."Poka¿ Listê Bitew Gildii" begin
			local g = guild.get_warp_war_list() -- return format {{1,2}, {3,4}}
			local gname_table = {}
			table.foreachi(g,
				function(n, p) 
				gname_table[n] = guild.get_name(p[1]) .. " vs " .. guild.get_name(p[2])
			end) -- if

			if table.getn(g) == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("W tej chwili nie ma ¿adnych wojen.")
				say("")
			else
				gname_table[table.getn(g)+1] = "Kontynuuj"
				say("Obecnie odbywaj¹ siê nastêpuj¹ce Wojny Gildii:")
				say("Jeœli chcesz byæ obserwatorem, wybierz któr¹œ z")
				say("pozycji.")
				local s = select_table(gname_table)
				if s != table.getn(gname_table) then
					pc.warp_to_guild_war_observer_position(g[s][1], g[s][2])
				end -- if
			end -- if
		end -- when

		when guild_war_observer3.chat."Poka¿ Listê Bitew Gildii" begin
			local g = guild.get_warp_war_list() -- return format {{1,2}, {3,4}}
			local gname_table = {}
			table.foreachi(g,
				function(n, p) 
				gname_table[n] = guild.get_name(p[1]) .. " vs " .. guild.get_name(p[2])
			end) -- if

			if table.getn(g) == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("W tej chwili nie ma ¿adnych wojen.")
				say("")
			else
				gname_table[table.getn(g)+1] = "Kontynuuj"
				say("Obecnie odbywaj¹ siê nastêpuj¹ce Wojny Gildii:")
				say("Jeœli chcesz byæ obserwatorem, wybierz któr¹œ z")
				say("pozycji.")
				local s = select_table(gname_table)
				if s != table.getn(gname_table) then
					pc.warp_to_guild_war_observer_position(g[s][1], g[s][2])
				end -- if
			end -- if
		end -- when
	end -- state
end -- quest
