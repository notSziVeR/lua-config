quest Zuo_Event begin
	state start begin
		when 20011.chat."Event Zuo - Wejœcie" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Ahh! Wiêc chcesz wzi¹æ udzia³ w Evencie ZUO..")
			say("Dobrze, daj mi chwilê..")
			say("")
			wait()
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			local check = zuo_event.can_enter()
			if check == -1 then
				say("Nie mo¿esz wejœæ.")
			elseif check == 1 then
				say("Na Event ZUO wchodziæ mo¿na tylko")
				say("na kanale pierwszym.")
			elseif check == 2 then
				say("Przykro mi, ale twój poziom doœwiadczenia")
				say("nie jest wystarczaj¹co wysoki, abyœ móg³ ")
				say("braæ udzia³ w Evencie ZUO.")
				say("")
				say_reward("Minimalny poziom doœwiadczenia wymagany do")
				say_reward("partycypowania w wydarzeniu: 80")
			elseif check == 3 then
				say("Przykro mi, ale aktualnie event jest wy³¹czony.")
			elseif check == 0 then
				say("Dobrze, mo¿esz wejœæ.")
				say("Jesteœ gotów?")
				if select("Tak", "Nie") == 1 then
					if zuo_event.can_enter() == 0 then
						zuo_event.enter()
					else
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Niestety, wejœcie nie jest ju¿ mo¿liwe.")
						say("")
					end -- if
				end-- if
			end -- if
		end -- when
	end -- state
end -- quest
