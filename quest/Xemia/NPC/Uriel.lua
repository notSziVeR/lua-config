define Uriel_Vnum 20011

quest Uriel begin
	state start begin
		when Uriel_Vnum.chat."Production Items" begin
			npc.open_cube();
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
