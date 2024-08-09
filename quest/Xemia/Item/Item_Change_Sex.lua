quest Item_Change_Sex begin
	state start begin
		when 71048.use begin
			if pc.get_level() < 75 then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("Chcia³byœ zmieniæ p³eæ?")
				say("Przykro mi lecz nie posiadasz")
				say("odpowiedniego poziomu by tego dokonaæ.")
				say("")
				say_reward("Aby zmieniæ p³eæ osi¹gnij 75 poziom!")
				say("")
				return;
			end -- if

			if pc.is_engaged() then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("Chcia³byœ zmieniæ p³eæ?")
				say("Przykro mi lecz nie mo¿esz zmieniæ ")
				say("p³ci gdy¿ jesteœ zarêczony!")
				say_reward("Nie mo¿esz zmieniæ p³ci bêd¹c zarêczonym!")
				say("")
				return;
			end -- if

			if pc.is_married() then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("")
				say("Chcia³byœ zmieniæ p³eæ?")
				say("Przykro mi lecz nie mo¿esz zmieniæ ")
				say("p³ci gdy¿ jesteœ w zwi¹zku!")
				say("")
				say_reward("Nie mo¿esz bêd¹c w zwi¹zku!")
				say("")
				return;
			end -- if

			if pc.is_polymorphed() then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("")
				say("Chcia³byœ zmieniæ p³eæ?")
				say("Przykro mi lecz nie mo¿esz zmieniæ ")
				say("p³ci gdy¿ jesteœ potworem!")
				say("")
				say_reward("Nie mo¿esz zmieniæ p³ci bêd¹c potworem!")
				say("")
				return;
			end -- if

			text_center() say_title(string.format("%s", item_name(71048)))
			say("_____________________________________________________")
			say("Wiêc chcia³byœ zmieniæ swoj¹ p³eæ?")
			say("")
			say("czy zdajesz sobie sprawê jakie tego")
			say("s¹ konsekwencje?")
			say("")
			wait()
			text_center() say_title(string.format("%s", item_name(71048)))
			say("_____________________________________________________")
			say("Mo¿esz zmieniaæ p³eæ tylko co trzy dni.")
			say("Nie mo¿esz ju¿ zmieniæ p³ci jak bêdziesz w zwi¹zku.")
			say("Czy jesteœ tego pewien?.")
			say("")
			say_reward("Czy chcesz zmieniæ swoj¹ p³eæ?")
			say("")
			local s = select("Tak, chcia³bym!", "Jednak siê rozmyœli³em..")
			if 1 == s then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("Zmieni³eœ swoj¹ p³eæ!")
				say("od teraz jesteœ inn¹ osob¹..")
				say("")
				say_reward("Proszê zmieñ postaæ w celu uaktualnienia p³ci.")
				say("")
				pc.remove_item("71048", 1);
				pc.change_sex();
			elseif 2 == s then
				text_center() say_title(string.format("%s", item_name(71048)))
				say("_____________________________________________________")
				say("S³uszny wybór!")
				say("Nie warto zmieniaæ p³ci..")
				say("")
			end -- if
		end -- when
	end -- state
end -- quest
