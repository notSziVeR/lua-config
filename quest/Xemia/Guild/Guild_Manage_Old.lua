define Create_Level 50
define Create_Gold 50000000

quest Guild_Manage_Old begin
	state start begin
		when guild_man1.chat."Za³ó¿ Gildie" or guild_man2.chat."Za³ó¿ Gildie" or guild_man3.chat."Za³ó¿ Gildie" with not pc.hasguild() begin
			if pc.hasguild() then
				return
			end -- if

			if (get_time() < pc.getqf("new_withdraw_time")) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo¿esz jeszcze za³o¿yæ gildii.")
				say("")
				-- say("Spróbuj ponownie za 23 godz. 59min.")
				say_reward(string.format("Pozosta³y Czas: %s.", Get_Time_Format(pc.getqf("new_withdraw_time") - get_time())))
				-- say(string.format("%s", time_to_str(pc.getqf("new_withdraw_time"))))
				say("")
				return
			end -- if

			if (get_time() < pc.getqf("new_disband_time")) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo¿esz jeszcze za³o¿yæ Gildii.")
				say("")
				-- say("Spróbuj ponownie za 23 godz. 59min.")
				say_reward(string.format("Pozosta³y Czas: %s.", Get_Time_Format(pc.getqf("new_disband_time") - get_time())))
				-- say(string.format("%s", time_to_str(pc.getqf("new_disband_time"))))
				say("")
				return
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Czy¿byœ chcia³ stworzyæ w³asn¹ gildiê?")
			say("Bêdzie ciê to kosztowaæ 50.000.000 Yang.")
			say("Dodatkowo musisz posiadaæ 50 poziom.")
			say("")
			say_reward("Czy chcesz za³o¿yæ gildie")
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
					say("Nie posiadasz wystarczaj¹cej iloœci Yang.")
					say("")
					say_item("50.000.000 Yang", 1, "")
					say("")
				end --if
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Musisz posiadaæ 50 poziom, ¿eby zostaæ liderem gildii.")
				say("")
			end --if
		end -- when

		when guild_man1.chat."Opuœæ Gildie" or guild_man2.chat."Opuœæ Gildie" or guild_man3.chat."Opuœæ Gildie" with pc.hasguild() and not pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jesteœ pewien, ¿e chcesz opuœciæ gildiê?")
			say("Od tej decyzji nie bêdzie odwo³ania!")
			say("")
			local s = select("Tak", "Nie")
			if s == 1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Opuœci³eœ gildiê!")
				say("")
				pc.remove_from_guild()
				pc.setqf("new_withdraw_time", get_time() + 60 * 60 * 24);
			end -- if
		end -- when

		when guild_man1.chat."Rozwi¹¿ Gildie" or guild_man2.chat."Rozwi¹¿ Gildie" or guild_man3.chat."Rozwi¹¿ Gildie" with pc.hasguild() and pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jesteœ pewien, ¿e chcesz to zrobiæ?")
			say("Ca³y wasz dorobek i s³awa odejd¹ w niepamiêæ...")
			say("Zastanów siê dwa razy zanim rozwi¹¿esz swoj¹ gildiê.")
			say("")
			say_reward("Jesteœ pewien, ¿e chcesz rozwi¹zaæ swoj¹ gildiê?")
			say("")
			local s = select("Tak", "Nie")
			if s == 1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Twoja gildia zosta³a rozwi¹zana.")
				say("")
				pc.destroy_guild()
				pc.setqf("new_disband_time", get_time() + 60 * 60 * 24);
			end -- if
		end -- when
	end -- state
end -- quest
