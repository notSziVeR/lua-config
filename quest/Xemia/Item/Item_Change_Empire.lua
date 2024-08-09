quest Item_Change_Empire begin
	state start begin
		when 71054.use begin
			if not pc.can_warp() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say("Nie mo�esz teraz tego zrobi�.")
				say("Spr�buj ponownie p�niej.")
				say("")
				return false;
			end -- if

			text_center() say_title(string.format("%s", item_name(71003)))
			say("_____________________________________________________")
			if get_time() < pc.getqf("next_use_time") then
				say("Nie mo�esz u�y� tego przedmiotu!")
				say("")
				say_reward("Kr�lestwo mo�esz zmieni� tylko raz.")
				say("")
				if pc.is_gm() then
					say("GM - Czy wyzerowa� czas?")
					say("")
					local s = select("Tak", "Nie")
					if s == 1 then
						say("Czas oczekiwania zosta� wyzerowany.")
						pc.setqf("next_use_time", 0)
					end -- if
				end -- if
				return
			end -- if

			if Item_Change_Empire.move_pc() == true then
				pc.setqf("next_use_time", get_time() + 86400 * 1)
			end -- if
		end -- when

		function move_pc()
			if pc.is_engaged() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say_reward("Wszystkie zar�czone postacie nie mog� zmieni� ")
				say_reward("swojego Kr�lestwa.")
				say("")
				say("Je�eli jeste� teraz w jakim� zwi�zku, to nie")
				say("mo�esz zmieni� swojego Kr�lestwa - zmiana ta jest")
				say("dost�pna tylko dla graczy niezar�czonych.")
				say("")
				return false
			end -- if

			if pc.is_married() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say_reward("Wszystkie zar�czone postacie nie mog� zmieni� ")
				say("swojego Kr�lestwa.")
				say("")
				say("Je�eli chcesz zmieni� Kr�lestwo, we� rozw�d.")
				say("")
				return false
			end -- if

			if pc.is_polymorphed() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say_reward("Nie mo�esz zmieni� Kr�lestwa, je�eli jeste� ")
				say("przemieniony.")
				say("")
				say("U�yj tego przedmiotu gdy nie b�dziesz")
				say("przemieniony.")
				say("")
				return false
			end -- if

			if pc.has_guild() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say_reward("Nie mo�esz zmieni� Kr�lestwa, poniewa� jeste� ")
				say("cz�onkiem gildii.")
				say("")
				say("U�yj tego przedmiotu gdy nie b�dziesz ju� ")
				say("cz�onkiem gildii.")
				say("")
				return false
			end -- if

			say("Do kt�rego Kr�lestwa chcesz si� przenie��?")
			say("")
			local s = select("Shinsoo", "Jinno", "Anuluj")
			if 3 == s then
				return false
			end -- if

			text_center() say_title(string.format("%s", item_name(71003)))
			say("_____________________________________________________")
			say("Czy na pewno chcesz zmieni� Kr�lestwo? Nie")
			say("b�dziesz m�g� tego cofn��...")
			say("")
			local a = select("Tak", "Anuluj")
			if 2 == a then
				return false
			end -- if

			local ret_empire = {1, 3}
			local ret = pc.change_empire(ret_empire[s])
			local oldempire = pc.get_empire()
			if ret == 999 then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say("Prosz� si� wylogowa� i ponownie zalogowa�, aby")
				say("doko�czy� proces.")
				say("")
				pc.change_gold(-500000)
				pc.remove_item(71054, 1);
				char_log(0, "CHANGE_EMPIRE", string.format("%d -> %d", oldempire, s))
				return true
			else
				if ret == 1 then
					text_center() say_title(string.format("%s", item_name(71003)))
					say("_____________________________________________________")
					say("Wybra�e� to samo Kr�lestwo, do kt�rego teraz")
					say("nale�ysz. Nie mia�e� zamiaru zmieni� Kr�lestwa?")
					say("")
				elseif ret == 2 then
					text_center() say_title(string.format("%s", item_name(71003)))
					say("_____________________________________________________")
					say("Wybrane Kr�lestwo.")
					say("")
					say("Jeste� w gildii. Co najmniej jedna z Twoich")
					say("postaci na tym serwerze jest aktualnie w gildii.")
					say("")
				elseif ret == 3 then
					text_center() say_title(string.format("%s", item_name(71003)))
					say("_____________________________________________________")
					say("Wybrane Kr�lestwo.")
					say("Masz m�a/�on�.")
					say("Co najmniej jedna z Twoich postaci na tym")
					say("serwerze jest aktualnie w zwi�zku.")
					say("")
				end -- if
			end -- if
			return false
		end -- function
	end -- state
end -- quest
