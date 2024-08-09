quest Training_Grandmaster_Skill begin
	state start begin
		function Is_Quest_Available(Is_Item)
			if not pc.can_warp() then
				text_center() say_title(string.format("%s", item_name(50513)))
				say("_____________________________________________________")
				say("Nie mo¿esz teraz tego zrobiæ.")
				say("Spróbuj ponownie póŸniej.")
				say("")
				return false;
			end -- if

			if Is_Item then
				if (pc.count_item(item.get_vnum()) == 0) then
					text_center() say_title(string.format("%s", item_name(50513)))
					say("_____________________________________________________")
					say("Nie masz wymaganego przedmiotu w ekwipunku!")
					say("")
					return false;
				end -- if
			end -- if

			if pc.is_trade0() then
				text_center() say_title(string.format("%s", item_name(50513)))
				say("_____________________________________________________")
				say("Zamknij okno handlu!")
				say("")
				return false;
			end -- if

			if pc.is_busy0() then
				text_center() say_title(string.format("%s", item_name(50513)))
				say("_____________________________________________________")
				say("Zamknij pozosta³e okna!")
				say("")
				return false;
			end -- if

			return true;
		end -- function

		function Insert_Skill_Data()
			local Player_Job = pc.get_job();
			local Player_Group = pc.get_skill_group();
			local Selected_Table = Player_Skill_Data[Player_Job + 1][Player_Group];

			local Minimum_Skill_Level = 30;
			local Maximum_Skill_Level = 40;

			local Select_Skill_Table = {["Skill_Data"] = {}, ["Skill_Index"] = {}};
			for index in Selected_Table["Skill_Vnums"] do
				local Skill_Level = pc.get_skill_level(Selected_Table["Skill_Vnums"][index]);

				if ((Skill_Level >= Minimum_Skill_Level) and (Skill_Level < Maximum_Skill_Level)) then
					local String_Value = Training_Grandmaster_Skill.Return_Skill_String(index);
					table.insert(Select_Skill_Table["Skill_Data"], string.format("%s", String_Value));
					table.insert(Select_Skill_Table["Skill_Index"], index);
					text_center() say_title(string.format("%s", item_name(50513)))
					say("_____________________________________________________")
					say("Proszê wybraæ umiejêtnoœæ, któr¹ chcesz trenowaæ.")
					say("")
				end -- if
			end -- for

			table.insert(Select_Skill_Table["Skill_Data"], "Anuluj");
			return Select_Skill_Table;
		end -- function

		function Return_Skill_String(index)
			local Player_Job = pc.get_job();
			local Player_Group = pc.get_skill_group();
			local Selected_Table = Player_Skill_Data[Player_Job + 1][Player_Group];

			local Skill_Level = pc.get_skill_level(Selected_Table["Skill_Vnums"][index]);
			local Skill_Attribute = "G";
			local Skill_Status = Skill_Level + 2 - 30;

			if (Skill_Status > 10) then
				Skill_Attribute = "P";
				Skill_Status = 1;
			end -- if

			return string.format("%s (G%d » %s%d)", Selected_Table["Skill_Names"][index], Skill_Level + 1 - 30, Skill_Attribute, Skill_Status);
		end -- function

		when 50513.use or 50569.use begin
			if (pc.get_skill_group() == 0) then
				text_center() say_title(string.format("%s", item_name(50513)))
				say("_____________________________________________________")
				say("Nie okreœli³eœ jeszcze swojej profesji.")
				say("")
				return;
			end -- if

			local Player_Job = pc.get_job();
			local Player_Group = pc.get_skill_group();
			local Selected_Table = Player_Skill_Data[Player_Job + 1][Player_Group];

			local Skill_Array = Training_Grandmaster_Skill.Insert_Skill_Data();
			if (table.getn(Skill_Array["Skill_Data"]) < 2) then
				text_center() say_title(string.format("%s", item_name(50513)))
				say("_____________________________________________________")
				say("Aby skorzystaæ z tego przedmiotu, najpierw musisz")
				say("rozwin¹æ odpowiednio co najmniej jedn¹ ")
				say("umiejêtnoœæ!")
				say("")
				return;
			end -- if

			local Select_Choice = select_table(Skill_Array["Skill_Data"]);
			if (Select_Choice == table.getn(Skill_Array["Skill_Data"])) then
				return;
			end -- if

			if (Training_Grandmaster_Skill.Is_Quest_Available(true)) then
				local Skill_Level = pc.get_skill_level(Selected_Table["Skill_Vnums"][Skill_Array["Skill_Index"][Select_Choice]]);
				local String_Value = Training_Grandmaster_Skill.Return_Skill_String(Skill_Array["Skill_Index"][Select_Choice]);

				local Current_Aligment = pc.get_real_alignment();
				local Require_Aligment = 1000 + 500 * (Skill_Level - 30)
				local Sum_Aligment = pc.get_real_alignment() - (1000 + 500 * (Skill_Level - 30))

				text_center() say_title(string.format("%s", item_name(50513)))
				say("_____________________________________________________")
				say(string.format("Czy na pewno chcesz trnowaæ umiejêtnoœæ:[ENTER]%s?", String_Value))
				say("")
				say_reward(string.format("Posiadane Punkty Rangi: %d.", Current_Aligment))
				say_reward(string.format("Wymagane Punkty Rangi: %d.", Require_Aligment))
				say_reward(string.format("Punkty Rangi po pomyœlnym treningu: %d.", Sum_Aligment))
				say("")
				if (select("Tak", "Nie") == 1) then
					if (Training_Grandmaster_Skill.Is_Quest_Available(true)) then
						local Current_Aligment = pc.get_real_alignment();
						local Require_Aligment = 1000 + 500 * (Skill_Level - 30)
						if Current_Aligment <- 19000 + Require_Aligment then
							text_center() say_title(string.format("%s", item_name(50513)))
							say("_____________________________________________________")
							say("Nie masz wystarczaj¹cej Punktów Rangi.")
							say_reward(string.format("Wymagane Punkty Rangi: %d.", Require_Aligment))
							say("")
							return;
						end -- if

						if pc.learn_grand_master_skill(Selected_Table["Skill_Vnums"][Skill_Array["Skill_Index"][Select_Choice]]) then
							pc.change_alignment(-Require_Aligment);
						else
							pc.change_alignment(-number(Require_Aligment / 3, Require_Aligment / 2));
						end -- if

						pc.remove_item(item.get_vnum(), 1);
					end -- if
				end -- if
			end -- if
		end -- when
	end -- state
end -- quest
