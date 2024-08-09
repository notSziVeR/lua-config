define Alchemist 20001

quest Dragon_Soul_Refine begin
	state start begin
		when Alchemist.chat."Refinement of Dragon Stones" begin
			ds.open_refine_window();
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
