define Old_Lady 9006

quest Reset_Skill begin
	state start begin
		when Old_Lady.chat."Reset Umiej�tno�ci" with pc.get_level() > 30 begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Witaj, przyszed�e� we w�a�ciwe miejsce.") 
			say("W Twoich oczach widz� du�o smutku.")
			say("Pozwalam ludziom zapomnie� o ich przesz�o�ci,")
			say("mog� zacz�� jeszcze raz...")
			say("")
			say_oldwoman("Czy chcesz zresetowa� swoje umiej�tno�ci?")
			say("")
			local Select = select("Tak", "Nie")
			if 1 == Select then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Umiej�tno�ci zosta�y pomy�lnie zresetowane.")
				say("Mo�esz teraz wybra� now� �cie�k� rozwoju.")
				say("")
				pc.clear_skill();
				pc.set_skill_group(0);
			elseif 2 == Select then
				return
			end -- IF
		end -- when
	end -- state
end -- quest
