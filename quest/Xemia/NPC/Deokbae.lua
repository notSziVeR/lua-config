define Deokbae_Vnum 20015

quest Deokbae begin
	state start begin
		when Deokbae_Vnum.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when Deokbae_Vnum.chat."Creation Melts" begin
			npc.open_cube();
			setskin(NOWINDOW);
		end -- when

		when Deokbae_Vnum.chat."Mineral Shards" begin
			command("legendary_stones_open_window 0")
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
