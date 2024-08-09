define Create_Level 50
define Create_Gold 50000000

quest Guild_Manage_Old begin
	state start begin
		when guild_man1.chat."Za�� Gildie" or guild_man2.chat."Za�� Gildie" or guild_man3.chat."Za�� Gildie" with not pc.hasguild() begin
			if pc.hasguild() then
				return
			end -- if

			if (get_time() < pc.getqf("new_withdraw_time")) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo�esz jeszcze za�o�y� gildii.")
				say("")
				-- say("Spr�buj ponownie za 23 godz. 59min.")
				say_reward(string.format("Pozosta�y Czas: %s.", Get_Time_Format(pc.getqf("new_withdraw_time") - get_time())))
				-- say(string.format("%s", time_to_str(pc.getqf("new_withdraw_time"))))
				say("")
				return
			end -- if

			if (get_time() < pc.getqf("new_disband_time")) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo�esz jeszcze za�o�y� Gildii.")
				say("")
				-- say("Spr�buj ponownie za 23 godz. 59min.")
				say_reward(string.format("Pozosta�y Czas: %s.", Get_Time_Format(pc.getqf("new_disband_time") - get_time())))
				-- say(string.format("%s", time_to_str(pc.getqf("new_disband_time"))))
				say("")
				return
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Czy�by� chcia� stworzy� w�asn� gildi�?")
			say("B�dzie ci� to kosztowa� 50.000.000 Yang.")
			say("Dodatkowo musisz posiada� 50 poziom.")
			say("")
			say_reward("Czy chcesz za�o�y� gildie")
			say("")
			local s = select("Tak", "Nie")
			if s == 2 then
				return
			end -- if

			if pc.level >= Create_Level then
				if pc.gold >= Create_Gold then
					game.request_make_guild()
				else
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Nie posiadasz wystarczaj�cej ilo�ci Yang.")
					say("")
					say_item("50.000.000 Yang", 1, "")
					say("")
				end --if
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Musisz posiada� 50 poziom, �eby zosta� liderem gildii.")
				say("")
			end --if
		end -- when

		when guild_man1.chat."Opu�� Gildie" or guild_man2.chat."Opu�� Gildie" or guild_man3.chat."Opu�� Gildie" with pc.hasguild() and not pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jeste� pewien, �e chcesz opu�ci� gildi�?")
			say("Od tej decyzji nie b�dzie odwo�ania!")
			say("")
			local s = select("Tak", "Nie")
			if s == 1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Opu�ci�e� gildi�!")
				say("")
				pc.remove_from_guild()
				pc.setqf("new_withdraw_time", get_time() + 60 * 60 * 24);
			end -- if
		end -- when

		when guild_man1.chat."Rozwi�� Gildie" or guild_man2.chat."Rozwi�� Gildie" or guild_man3.chat."Rozwi�� Gildie" with pc.hasguild() and pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jeste� pewien, �e chcesz to zrobi�?")
			say("Ca�y wasz dorobek i s�awa odejd� w niepami��...")
			say("Zastan�w si� dwa razy zanim rozwi��esz swoj� gildi�.")
			say("")
			say_reward("Jeste� pewien, �e chcesz rozwi�za� swoj� gildi�?")
			say("")
			local s = select("Tak", "Nie")
			if s == 1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Twoja gildia zosta�a rozwi�zana.")
				say("")
				pc.destroy_guild()
				pc.setqf("new_disband_time", get_time() + 60 * 60 * 24);
			end -- if
		end -- when
	end -- state
end -- quest
