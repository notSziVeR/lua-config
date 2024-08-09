define Create_Level 50
define Create_Gold 50000000

quest Guild_Manage begin
	state start begin
		when guild_man1.chat."Za³ó¿ Gildie" or guild_man2.chat."Za³ó¿ Gildie" or guild_man3.chat."Za³ó¿ Gildie" with not pc.hasguild() begin
			local level_limit;
			local guild_create_item;
			if get_locale() == "eng" then
				level_limit = 50;
				guild_create_item = false;
			else
				level_limit = 50;
				guild_create_item = false;
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Czy¿byœ chcia³ stworzyæ w³asn¹ gildiê?")
			say("Bêdzie ciê to kosztowaæ 50.000.000 Yang.")
			say("Dodatkowo musisz posiadaæ 50 poziom.")
			say("")
			say_reward("Czy chcesz za³o¿yæ gildie?")
			say("")
			local s = select("Tak", "Nie")
			if s == 2 then
				return;
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Podaj nazwê gildii:")
			local Guild_Name = string.gsub(input(), "[^A-Za-z0-9]", "");
			local Guild_Length_Name = string.len(Guild_Name);
			if not ((2 < Guild_Length_Name) and (Guild_Length_Name < 12)) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazwa nie powinna zawieraæ znaków specjalnych, a")
				say("jej d³ugoœæ powinna wynosiæ od 2 do 11 znaków.")
				say("")
				return;
			end -- if
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Czy chcesz za³o¿yæ gildie o podanej nazwie?")
			say_guild_name(string.format("%s", Guild_Name))
			say("")
			if select("Za³ó¿ Gildie", "Zakoñcz") == 2 then
				return;
			end -- if

			if not (pc.get_gold() >= Create_Gold) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie posiadasz wystarczaj¹cej iloœci Yang.")
				say("")
				say_item("50.000.000 Yang", 1, "")
				say("")
				return;
			end -- if

			if (pc.hasguild() or pc.isguildmaster()) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo¿esz tego zrobiæ bêd¹c w gildii.")
				say("")
				return;
			end -- if

			if not (pc.get_level() >= Create_Level) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Musisz posiadaæ 50 poziom, ¿eby zostaæ Liderem Gildii.")
				say("")
				return;
			end -- if

			local ret = pc.make_guild0(Guild_Name);
			if ret == -2 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Z³a d³ugoœæ nazwy gildii.")
				say("")
				say("Nazwa Gildii musi mieæ od 2 do 12 znaków.")
				say("")
			elseif ret == -1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazwa gildii nie mo¿e posiadaæ znaków")
				say("specjalnych oraz spacji.")
				say("")
			elseif ret == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Podana nazwa gildii jest ju¿ zajêta.")
				say("")
			elseif ret == 1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Gildia zosta³a pomyœlnie za³o¿ona!")
				say("")
				pc.change_gold(-Create_Gold);
				return true;
			elseif ret == 2 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo¿esz tego zrobiæ bêd¹c w gildii.")
				say("")
			elseif ret == 3 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo¿esz tego zrobiæ bêd¹c w gildii.")
				say("")
			end -- if
			return;
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
				pc.remove_from_guild();
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
				pc.destroy_guild();
			end -- if
		end -- when
	end -- state
end -- quest
