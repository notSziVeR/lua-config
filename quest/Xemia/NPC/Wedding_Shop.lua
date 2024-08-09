define Old_Lady_Vnum 9006
define Peddler_Vnum 20010

quest Wedding_Shop begin
	state start begin
		when Old_Lady_Vnum.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when

		when Peddler_Vnum.chat."Open Shop" begin
			npc.open_shop();
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
