quest Guild_War_Join begin
	state start begin
		when letter begin
			local e = guild.get_any_war()
			if e != 0 and pc.get_war_map() == 0 then
				send_letter("Poproœ o zezwolenie na udzia³ ")
			end -- if
		end -- when

		when button or info begin
			local e = guild.get_any_war()
			if e == 0 then
				say("Wojna siê ju¿ skoñczy³a.")
			else
				say("{}" .. guild.name(e) .. "Czy chcesz wzi¹æ udzia³ w bitwie?")
			end -- if

			local s = select("Tak", "Nie")
			if s == 1 then
				guild.war_enter(e)
			else
				send_letter("Poproœ o zezwolenie na udzia³ ")
			end -- if
		end -- when
	end -- state
end -- quest
