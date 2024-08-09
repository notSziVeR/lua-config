define Create_Level 50
define Create_Gold 50000000

quest Guild_Manage begin
	state start begin
		when guild_man1.chat."Za�� Gildie" or guild_man2.chat."Za�� Gildie" or guild_man3.chat."Za�� Gildie" with not pc.hasguild() begin
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
			say("Czy�by� chcia� stworzy� w�asn� gildi�?")
			say("B�dzie ci� to kosztowa� 50.000.000 Yang.")
			say("Dodatkowo musisz posiada� 50 poziom.")
			say("")
			say_reward("Czy chcesz za�o�y� gildie?")
			say("")
			local s = select("Tak", "Nie")
			if s == 2 then
				return;
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Podaj nazw� gildii:")
			local Guild_Name = string.gsub(input(), "[^A-Za-z0-9]", "");
			local Guild_Length_Name = string.len(Guild_Name);
			if not ((2 < Guild_Length_Name) and (Guild_Length_Name < 12)) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazwa nie powinna zawiera� znak�w specjalnych, a")
				say("jej d�ugo�� powinna wynosi� od 2 do 11 znak�w.")
				say("")
				return;
			end -- if
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Czy chcesz za�o�y� gildie o podanej nazwie?")
			say_guild_name(string.format("%s", Guild_Name))
			say("")
			if select("Za�� Gildie", "Zako�cz") == 2 then
				return;
			end -- if

			if not (pc.get_gold() >= Create_Gold) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie posiadasz wystarczaj�cej ilo�ci Yang.")
				say("")
				say_item("50.000.000 Yang", 1, "")
				say("")
				return;
			end -- if

			if (pc.hasguild() or pc.isguildmaster()) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo�esz tego zrobi� b�d�c w gildii.")
				say("")
				return;
			end -- if

			if not (pc.get_level() >= Create_Level) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Musisz posiada� 50 poziom, �eby zosta� Liderem Gildii.")
				say("")
				return;
			end -- if

			local ret = pc.make_guild0(Guild_Name);
			if ret == -2 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Z�a d�ugo�� nazwy gildii.")
				say("")
				say("Nazwa Gildii musi mie� od 2 do 12 znak�w.")
				say("")
			elseif ret == -1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazwa gildii nie mo�e posiada� znak�w")
				say("specjalnych oraz spacji.")
				say("")
			elseif ret == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Podana nazwa gildii jest ju� zaj�ta.")
				say("")
			elseif ret == 1 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Gildia zosta�a pomy�lnie za�o�ona!")
				say("")
				pc.change_gold(-Create_Gold);
				return true;
			elseif ret == 2 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo�esz tego zrobi� b�d�c w gildii.")
				say("")
			elseif ret == 3 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo�esz tego zrobi� b�d�c w gildii.")
				say("")
			end -- if
			return;
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
				pc.remove_from_guild();
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
				pc.destroy_guild();
			end -- if
		end -- when
	end -- state
end -- quest
