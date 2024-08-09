define Old_Lady 9006

quest Reset_Skill begin
	state start begin
		when Old_Lady.chat."Reset Umiejêtnoœci" with pc.get_level() > 30 begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Witaj, przyszed³eœ we w³aœciwe miejsce.") 
			say("W Twoich oczach widzê du¿o smutku.")
			say("Pozwalam ludziom zapomnieæ o ich przesz³oœci,")
			say("mog¹ zacz¹æ jeszcze raz...")
			say("")
			say_oldwoman("Czy chcesz zresetowaæ swoje umiejêtnoœci?")
			say("")
			local Select = select("Tak", "Nie")
			if 1 == Select then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Umiejêtnoœci zosta³y pomyœlnie zresetowane.")
				say("Mo¿esz teraz wybraæ now¹ œcie¿kê rozwoju.")
				say("")
				pc.clear_skill();
				pc.set_skill_group(0);
			elseif 2 == Select then
				return
			end -- IF
		end -- when
	end -- state
end -- quest
