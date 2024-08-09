quest Zuo_Event begin
	state start begin
		when 20011.chat."Event Zuo - Wej�cie" begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Ahh! Wi�c chcesz wzi�� udzia� w Evencie ZUO..")
			say("Dobrze, daj mi chwil�..")
			say("")
			wait()
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			local check = zuo_event.can_enter()
			if check == -1 then
				say("Nie mo�esz wej��.")
			elseif check == 1 then
				say("Na Event ZUO wchodzi� mo�na tylko")
				say("na kanale pierwszym.")
			elseif check == 2 then
				say("Przykro mi, ale tw�j poziom do�wiadczenia")
				say("nie jest wystarczaj�co wysoki, aby� m�g� ")
				say("bra� udzia� w Evencie ZUO.")
				say("")
				say_reward("Minimalny poziom do�wiadczenia wymagany do")
				say_reward("partycypowania w wydarzeniu: 80")
			elseif check == 3 then
				say("Przykro mi, ale aktualnie event jest wy��czony.")
			elseif check == 0 then
				say("Dobrze, mo�esz wej��.")
				say("Jeste� got�w?")
				if select("Tak", "Nie") == 1 then
					if zuo_event.can_enter() == 0 then
						zuo_event.enter()
					else
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Niestety, wej�cie nie jest ju� mo�liwe.")
						say("")
					end -- if
				end-- if
			end -- if
		end -- when
	end -- state
end -- quest
