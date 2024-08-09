define Theowahdan_Vnum 60003

quest Shoulder_Sash_System begin
	state start begin
		when Theowahdan_Vnum.chat."Shoulder Sash: Production" begin
			npc.open_cube();
			setskin(NOWINDOW);
		end -- when

		when Theowahdan_Vnum.chat."Shoulder Sash: Combination" begin
			command("open_sash_combination");
			setskin(NOWINDOW);
		end -- when

		when Theowahdan_Vnum.chat."Shoulder Sash: Absorption" begin
			command("open_sash_absorption");
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
