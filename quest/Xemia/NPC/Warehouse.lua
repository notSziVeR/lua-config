define Storekeeper_Vnum 9005

quest Warehouse begin
	state start begin
		when Storekeeper_Vnum.chat."Open Safebox" begin
			game.open_safebox();
			setskin(NOWINDOW);
		end -- when

		when Storekeeper_Vnum.chat."Open Safebox - Item Shop" begin
			game.open_mall();
			setskin(NOWINDOW);
		end -- when
	end -- state
end -- quest
