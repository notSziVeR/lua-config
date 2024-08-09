define Gaya_Market_Vnum 20504

quest Gaya_System begin
	state start begin
		when Gaya_Market_Vnum.chat."Gaya: Production Gaya" begin
			setskin(NOWINDOW);
			cmdchat("OpenGayaCrafting");
		end -- when

		when Gaya_Market.chat."Gaya: Production" begin
			npc.open_cube();
			setskin(NOWINDOW);
		end -- when

		when Gaya_Market.chat."Gaya: Shop" begin
			setskin(NOWINDOW);
			cmdchat("RequestGayaMarket");
		end -- when
	end -- state
end -- quest
