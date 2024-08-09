quest Reset_Scroll begin
	state start begin
		when 71002.use begin
			if not pc.can_warp() then
				text_center() say_title(string.format("%s:", item_name(71002)))
				say("_____________________________________________________")
				say("Nie mo�esz teraz tego zrobi�.")
				say("Spr�buj ponownie p�niej.")
				say("")
				return;
			end -- if

			text_center() say_title(string.format("%s:", item_name(71002)))
			say("_____________________________________________________")
			say("Czy chcesz zresetowa� punkty statusu?") 
			say("")
			local Select = select("Tak", "Nie");
			if 1 == Select then
				pc.remove_item(71002);
				pc.reset_point();
			end -- if
		end -- when

		when 71003.use begin
			if not pc.can_warp() then
				text_center() say_title(string.format("%s:", item_name(71003)))
				say("_____________________________________________________")
				say("Nie mo�esz teraz tego zrobi�.")
				say("Spr�buj ponownie p�niej.")
				say("")
				return;
			end -- if

			local Result = BuildSkillList(pc.get_job(), pc.get_skill_group());
			local Vnum_List = Result[1];
			local Name_List = Result[2];
			if table.getn(Vnum_List) < 2 then
				text_center() say_title(string.format("%s:", item_name(71003)))
				say("_____________________________________________________")
				say("Nie ma umiej�tno�ci, kt�re mog�yby by� ")
				say("zresetowane.")
				say("")
				return;
			end -- if
			
			text_center() say_title(string.format("%s:", item_name(71003)))
			say("_____________________________________________________")
			say("Wybierz umiej�tno��, kt�r� chcesz zresetowa�:")
			say("")
			local i = select_table(Name_List)
			if table.getn(Name_List) == i then
				return;
			end -- if
			local Name = Name_List[i];
			local Vnum = Vnum_List[i];
			text_center() say_title(string.format("%s:", item_name(71003)))
			say("_____________________________________________________")
			say("Czy na pewno chcesz zresetowa�?")
			say_guild_name(string.format("%s:", Name))
			say("")
			local Select = select("Tak", "Nie");
			if 1 == Select then
				text_center() say_title(string.format("%s:", item_name(71003)))
				say("")
				say("Umiej�tno�� zosta�a pomy�lnie zresetowana.")
				say("")
				pc.remove_item(71003);
				pc.clear_one_skill(Vnum);
			elseif 2 == Select then
				return;
			end -- if
		end -- when
	end -- state
end -- quest
