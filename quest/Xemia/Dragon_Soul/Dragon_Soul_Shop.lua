define Alchemist_Vnum 20001

quest Dragon_Soul_Shop begin
	state start begin
		when Alchemist_Vnum.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
