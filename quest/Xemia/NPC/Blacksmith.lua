define Blacksmith_Vnum 20016

quest Blacksmith begin
	state start begin
		when Blacksmith_Vnum.chat."Production Items" begin
			npc.open_cube();
			setskin(NOWINDOW);
		end -- when

		when Blacksmith_Vnum.chat."Legendary Stones: Production" begin
			command("legendary_stones_open_window 2")
			setskin(NOWINDOW);
		end -- when

		when Blacksmith_Vnum.chat."Legendary Stones: Combination" begin
			command("legendary_stones_open_window 3")
			setskin(NOWINDOW);
		end -- when

		when Blacksmith_Vnum.chat."Legendary Stones: Stone Shards" begin
			command("legendary_stones_open_window 1")
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
