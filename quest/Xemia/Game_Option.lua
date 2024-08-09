quest Game_Option begin
	state start begin
		when login begin
			local Val = 0;
			local Msg = "Blokowane:" .. " ";
			if pc.getqf("block_exchange") == 1 then
				Msg = Msg .. "Handel";
				Val = Val + 1;
			end -- end

			if pc.getqf("block_guild_invite") == 1 then
				Val = Val + 4;
				Msg = Msg .. "Gildia" .. " ";
			end -- end

			if pc.getqf("block_messenger_invite") == 1 then
				Msg = Msg .. "Przyjaciel" .. " ";
				Val = Val + 16;
			end -- end

			if pc.getqf("block_party_invite") == 1 then
				Msg = Msg .. "Grupa" .. " ";
				Val = Val + 2;
			end -- end

			if pc.getqf("block_party_request") == 1 then
				Msg = Msg .. "Proœba" .. " ";
				Val = Val + 32;
			end -- end

			if pc.getqf("block_whisper") == 1 then
				Msg = Msg .. "Szept" .. " ";
				Val = Val + 8;
			end -- end

			if Val != 0 then
				syschat(Msg);
			end -- end

			pc.send_block_mode(Val);
		end -- when
	end -- state
end -- quest
