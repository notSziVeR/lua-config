quest Item_Change_Empire begin
	state start begin
		when 71054.use begin
			if not pc.can_warp() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say("Nie mo¿esz teraz tego zrobiæ.")
				say("Spróbuj ponownie póŸniej.")
				say("")
				return false;
			end -- if

			text_center() say_title(string.format("%s", item_name(71003)))
			say("_____________________________________________________")
			if get_time() < pc.getqf("next_use_time") then
				say("Nie mo¿esz u¿yæ tego przedmiotu!")
				say("")
				say_reward("Królestwo mo¿esz zmieniæ tylko raz.")
				say("")
				if pc.is_gm() then
					say("GM - Czy wyzerowaæ czas?")
					say("")
					local s = select("Tak", "Nie")
					if s == 1 then
						say("Czas oczekiwania zosta³ wyzerowany.")
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
				say_reward("Wszystkie zarêczone postacie nie mog¹ zmieniæ ")
				say_reward("swojego Królestwa.")
				say("")
				say("Je¿eli jesteœ teraz w jakimœ zwi¹zku, to nie")
				say("mo¿esz zmieniæ swojego Królestwa - zmiana ta jest")
				say("dostêpna tylko dla graczy niezarêczonych.")
				say("")
				return false
			end -- if

			if pc.is_married() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say_reward("Wszystkie zarêczone postacie nie mog¹ zmieniæ ")
				say("swojego Królestwa.")
				say("")
				say("Je¿eli chcesz zmieniæ Królestwo, weŸ rozwód.")
				say("")
				return false
			end -- if

			if pc.is_polymorphed() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say_reward("Nie mo¿esz zmieniæ Królestwa, je¿eli jesteœ ")
				say("przemieniony.")
				say("")
				say("U¿yj tego przedmiotu gdy nie bêdziesz")
				say("przemieniony.")
				say("")
				return false
			end -- if

			if pc.has_guild() then
				text_center() say_title(string.format("%s", item_name(71003)))
				say("_____________________________________________________")
				say_reward("Nie mo¿esz zmieniæ Królestwa, poniewa¿ jesteœ ")
				say("cz³onkiem gildii.")
				say("")
				say("U¿yj tego przedmiotu gdy nie bêdziesz ju¿ ")
				say("cz³onkiem gildii.")
				say("")
				return false
			end -- if

			say("Do którego Królestwa chcesz siê przenieœæ?")
			say("")
			local s = select("Shinsoo", "Jinno", "Anuluj")
			if 3 == s then
				return false
			end -- if

			text_center() say_title(string.format("%s", item_name(71003)))
			say("_____________________________________________________")
			say("Czy na pewno chcesz zmieniæ Królestwo? Nie")
			say("bêdziesz móg³ tego cofn¹æ...")
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
				say("Proszê siê wylogowaæ i ponownie zalogowaæ, aby")
				say("dokoñczyæ proces.")
				say("")
				pc.change_gold(-500000)
				pc.remove_item(71054, 1);
				char_log(0, "CHANGE_EMPIRE", string.format("%d -> %d", oldempire, s))
				return true
			else
				if ret == 1 then
					text_center() say_title(string.format("%s", item_name(71003)))
					say("_____________________________________________________")
					say("Wybra³eœ to samo Królestwo, do którego teraz")
					say("nale¿ysz. Nie mia³eœ zamiaru zmieniæ Królestwa?")
					say("")
				elseif ret == 2 then
					text_center() say_title(string.format("%s", item_name(71003)))
					say("_____________________________________________________")
					say("Wybrane Królestwo.")
					say("")
					say("Jesteœ w gildii. Co najmniej jedna z Twoich")
					say("postaci na tym serwerze jest aktualnie w gildii.")
					say("")
				elseif ret == 3 then
					text_center() say_title(string.format("%s", item_name(71003)))
					say("_____________________________________________________")
					say("Wybrane Królestwo.")
					say("Masz mê¿a/¿onê.")
					say("Co najmniej jedna z Twoich postaci na tym")
					say("serwerze jest aktualnie w zwi¹zku.")
					say("")
				end -- if
			end -- if
			return false
		end -- function
	end -- state
end -- quest
