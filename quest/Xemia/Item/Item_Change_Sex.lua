quest Item_Change_Sex begin
	state start begin
		when 71048.use begin
			if pc.get_level() < 75 then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("Chcia�by� zmieni� p�e�?")
				say("Przykro mi lecz nie posiadasz")
				say("odpowiedniego poziomu by tego dokona�.")
				say("")
				say_reward("Aby zmieni� p�e� osi�gnij 75 poziom!")
				say("")
				return;
			end -- if

			if pc.is_engaged() then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("Chcia�by� zmieni� p�e�?")
				say("Przykro mi lecz nie mo�esz zmieni� ")
				say("p�ci gdy� jeste� zar�czony!")
				say_reward("Nie mo�esz zmieni� p�ci b�d�c zar�czonym!")
				say("")
				return;
			end -- if

			if pc.is_married() then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("")
				say("Chcia�by� zmieni� p�e�?")
				say("Przykro mi lecz nie mo�esz zmieni� ")
				say("p�ci gdy� jeste� w zwi�zku!")
				say("")
				say_reward("Nie mo�esz b�d�c w zwi�zku!")
				say("")
				return;
			end -- if

			if pc.is_polymorphed() then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("")
				say("Chcia�by� zmieni� p�e�?")
				say("Przykro mi lecz nie mo�esz zmieni� ")
				say("p�ci gdy� jeste� potworem!")
				say("")
				say_reward("Nie mo�esz zmieni� p�ci b�d�c potworem!")
				say("")
				return;
			end -- if

			text_center() say_title(string.format("%s", item_name(71048)))
			say("_____________________________________________________")
			say("Wi�c chcia�by� zmieni� swoj� p�e�?")
			say("")
			say("czy zdajesz sobie spraw� jakie tego")
			say("s� konsekwencje?")
			say("")
			wait()
			text_center() say_title(string.format("%s", item_name(71048)))
			say("_____________________________________________________")
			say("Mo�esz zmienia� p�e� tylko co trzy dni.")
			say("Nie mo�esz ju� zmieni� p�ci jak b�dziesz w zwi�zku.")
			say("Czy jeste� tego pewien?.")
			say("")
			say_reward("Czy chcesz zmieni� swoj� p�e�?")
			say("")
			local s = select("Tak, chcia�bym!", "Jednak si� rozmy�li�em..")
			if 1 == s then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("Zmieni�e� swoj� p�e�!")
				say("od teraz jeste� inn� osob�..")
				say("")
				say_reward("Prosz� zmie� posta� w celu uaktualnienia p�ci.")
				say("")
				pc.remove_item("71048", 1);
				pc.change_sex();
			elseif 2 == s then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("S�uszny wyb�r!")
				say("Nie warto zmienia� p�ci..")
				say("")
			end -- if
		end -- when
	end -- state
end -- quest
