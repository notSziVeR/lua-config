quest Marriage_Manage begin
	state start begin
		when oldwoman.chat."We� �lub" with not pc.is_engaged_or_married() begin
			if not npc.lock() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Witam, jestem odpowiedzialana za �luby w tym")
				say("kraju, nie r�b pochopnych decyzji! Czy")
				say("na pewno chcesz wzi�� �lub?")
				return
			end -- if

			if pc.level < 25 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Niestety, aby unikn�� niepotrzenych �lub�w w")
				say("w naszym kr�lestwie wprowadzili�my restrykcj� ")
				say("poziomu. Dopiero Gracze kt�rzy posiadaj� poziom")
				say("wy�szy, ni� 25 mog� wzi�� �lub")
				say("")
				say_reward("Wr�� gdy osi�gniesz poziom wy�szy ni� 25")
				say("")
				npc.unlock()
				return
			end -- if

			local m_ring_num = pc.countitem(70301)
			local m_has_ring = m_ring_num > 0
			if not m_has_ring then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Musisz zdoby� Pier�cionek Zar�czynowy.")
				say("Dopiero wtedy b�dziesz m�g� wzi�� �lub.")
				say("")
				say_item("Pier�cionek Zar�czynowy", 70301, "")
				say("")
				npc.unlock()
				return
			end -- if

			local m_sex = pc.get_sex()
			if not Marriage_Manage.is_equip_wedding_dress() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Chcesz bra� �lub w tych szmatach?")
				say("Nie r�b sobie wstydu i ubierz si� jak")
				say("przysta�o na cz�owieka...")
				if m_sex == 0 then
					say_item("Smoking", Marriage_Manage.get_wedding_dress(pc.get_job()), "")
				else
					say_item("Suknia �lubna", Marriage_Manage.get_wedding_dress(pc.get_job()), "")
				end -- if
				say("")
				npc.unlock()
				return
			end -- if

			local NEED_MONEY = 1000000
			if pc.get_money() < NEED_MONEY then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say(" �lub nie jest tani! To kosztuje troszk� pieni�dzy")
				say("Ja r�wnie� musz� z czego� utrzyma� m�a i dzieci!")
				say("Przecie�, cz�owiek nie �yje sam� wod�...")
				say("Przyjd� gdy zdob�dziesz 1 Milion Yang.")
				say("")
				say_reward(string.format("Potrzebujesz %d? Yang", NEED_MONEY/10000))
				say("")
				npc.unlock()
				return
			end -- if

			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Mog� da� wam �lub, robi�am to wiele razy!")
			say("Na pewno nie zawiedziesz si� w sposobie")
			say("w jaki przeprowadz� �lub!")
			say("")
			say_reward("Podaj imi� osoby z kt�r� chcesz wzi�� �lub.")
			local sname = input()
			if sname == "" then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Tak wiem, ci�ko jest tak od razu podj�� w�a�ciw� ")
				say("decyzj�, lecz mo�esz do mnie wr�ci� gdy nadejdzie")
				say("w�a�ciwy moment, gdy b�dziesz pewny swojego wyboru.")
				say("")
				npc.unlock()
				return
			end -- if
			local u_vid = find_pc_by_name(sname)
			local m_vid = pc.get_vid()
			if u_vid == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie znasz imienia osoby z kt�r� chcesz wzi�� �lub?")
				say("To mo�e lepiej zrezygnuj z ma��e�stwa dla w�asnego")
				say("bezpiecze�stwa? Najlepiej odpocznij, prze�pij si� ")
				say("i przemy�l swoj� decyzj�. Wtedy imi� powinno Ci")
				say("si� przypomnie�!")
				say("")
				say_reward(string.format("Posta� %s nie jest zalogowana.", sname))
				say("")
				npc.unlock()
				return
			end -- if
			if not npc.is_near_vid(u_vid, 10) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Osoby kt�re maj� bra� �lub musz� by� bardzo")
				say("zdecydowane i zdeterminowane. A co najwa�niejsze")
				say("musz� by� blisko mi�dzy sob� psychicznie jak i")
				say("fizycznie. Popro� aby osoba stane�a blisko Ciebie")
				say("")
				say_reward(string.format("%s stoi za dalego od Ciebie", sname))
				say("")
				npc.unlock()
				return
			end -- if
			local old = pc.select(u_vid)
			local u_level = pc.get_level()
			local u_job = pc.get_job()
			local u_sex = pc.get_sex()
			local u_name = pc.name
			local u_gold = pc.get_money()
			local u_married = pc.is_married()
			local u_has_ring = pc.countitem(70301) > 0
			local u_wear = Marriage_Manage.is_equip_wedding_dress()
			pc.select(old)
			local m_level = pc.get_level()
			if u_vid == m_vid then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Ty si� tak nazywasz!")
				say("")
				say_reward("Nie mo�esz wzi�� �lubu z samym sob�!")
				say("")
				npc.unlock()
				return
			end -- if
			if u_sex == m_sex then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Przykro mi, ale ja udzielam tylko �lub�w")
				say("heteroseksualnych.")
				say("")
				say_reward("Nie mo�esz wzi�� �lubu z osob� o tej samej p�ci!")
				say("")
				npc.unlock()
				return
			end -- if
			if u_married then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Niestety ale ta osoba ju� wzi�a �lub.")
				say("To nie jest mo�liwe.")
				say("")
				say_reward(string.format("Posta� %s ma �lub.", sname))
				say("")
				npc.unlock()
				return
			end -- if
			if u_level < 25 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Niestety, ale ta osoba nie ma poziomu")
				say("wi�kszego ni� 25 i nie s�dz�, aby by�o")
				say("sta� t� osob� na sta�y zwi�zek!")
				say("")
				say_reward("Ta osoba musi mie� Poziom wi�kszy ni� 25")
				say("")
				npc.unlock()
				return
			end -- if
			if m_level - u_level > 15 or u_level - m_level > 15 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Niestety r�nica poziom�w mi�dzy wami jest")
				say("zbyt du�a. To zbyt ogromna rozbie�no�� poziomu")
				say("Nie mog� zezwoli� na ten �lub.")
				say("")
				say_reward("Nie mo�ecie si� r�ni� wi�cej ni� 15 poziomami.")
				say("")
				npc.unlock()
				return
			end -- if
			if not u_has_ring then
				if m_ring_num >= 2 then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Aby wzi�� �lub potrzebujesz 2 Pier�cionki")
					say("Zar�czynowe! Wr�� kiedy je zdob�dziesz.")
				else
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Nie mo�esz bra� �lubu bez 2 Pier�cionk�w")
					say("Zar�czynowych.")
					say("")
				end
				say_item("Pier�cionek Zar�czynowy", 70301, "")
				say_reward("Druga osoba te� musi mie� Pier�cionek")
				say_reward("Zar�czynowy.")
				say("")
				npc.unlock()
				return
			end -- if
			if not u_wear then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Chcecie zawrze� zwi�zek ma��e�ski a nawet nie")
				say("macie odpowiedniego stroju? Na co wy liczycie?")
				say("Nie mo�ecie si� pobra� gdy nie macie odpowiedniego")
				say("ubioru!")
				say("")
				if u_sex == 0 then
					say_item("Smoking", Marriage_Manage.get_wedding_dress(u_job), "")
					say_reward("Aby wzi��� �lub trzeba mie� za�o�ony str�j!")
				else
					say_item("Suknia �lubna", Marriage_Manage.get_wedding_dress(u_job), "")
					say_reward("Aby wzi��� �lub trzeba mie� za�o�ony str�j!")
				end -- if
				say("")
				npc.unlock()
				return
			end -- if
			local ok_sign = confirm( u_vid, "Chcesz wzi�� �lub z"..pc.name.. "?", 30)
			if ok_sign == CONFIRM_OK then
				local m_name = pc.name
				if pc.get_gold()>=NEED_MONEY then
					pc.change_gold(-NEED_MONEY)
					pc.removeitem(70301, 1)
					pc.give_item2(70302, 1)
					local old = pc.select(u_vid)
					pc.removeitem(70301, 1)
					pc.give_item2(70302, 1)
					pc.select(old)
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Jeste�my gotowi do zorganizowania �lubu!")
					say("Miejmy nadzieje, �e druga po��wka r�wnie� ")
					say("Ci� kocha! Pob�ogos�awi� was teraz, lecz sam")
					say("�lub obejdzie si� na wyspie Mi�o�ci!")
					say_reward("B�ogos�awi� was imieniem Boga Smok�w!")
					say("")
					wait()
					setskin(NOWINDOW)
					marriage.engage_to(u_vid)
				end -- if
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Osoba z kt�r� chcia�by� wzi�� �lub odm�wi�a")
				say(" wzi�cia go!Porozmawiaj z ni� na ten temat...")
				say("Powinno pom�c!")
				say("")
				say_reward("Niech Partner zaakceptuje �lub. Inaczej si� nie odb�dzie.")
			end -- if
				say("")
				npc.unlock()
		end -- when

		when oldwoman.chat."Wejd� na tw�j �lub!" with pc.is_engaged() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Zostaniesz przeniesiony.")
			wait()
			setskin(NOWINDOW)
			marriage.warp_to_my_marriage_map()
		end -- when

		when 9011.chat."Rozpocznij �lub" with pc.is_engaged() and marriage.in_my_wedding() begin
			if not npc.lock() then
				say("Tw�j partner nie jest na tej mapie!")
				say("")
				return
			end -- if
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Je�li partner")
			say("jest z innego kr�lestwa,")
			say("mo�e teraz")
			say("wypi� olejek wygnania.")
			say(" �lub mo�e rozwi�za� by�y partner.")
			local sname = input()
			local u_vid = find_pc_by_name(sname)
			local m_vid = pc.get_vid()
			if u_vid == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie znaleziono partnera.")
				say("")
				say_reward(string.format("Nie znaleziono gracza %s.", sname))
				say("")
				npc.unlock()
				return
			end -- if
			if not npc.is_near_vid(u_vid, 10) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie jeste�cie ko�o siebie! Nie mo�ecie si� ")
				say("pobra�! Sta�cie ko�o siebie...")
				say("")
				say_reward(string.format("%s musi stan�� ko�o siebie", sname))
				say("")
				npc.unlock()
				return
			end -- if
			if u_vid == m_vid then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie mo�esz wzi�� �lubu sam ze sob�!")
				say("")
				say_reward("Musisz j� zmieni�.")
				say("")
				npc.unlock()
				return
			end -- if
			if u_vid != marriage.find_married_vid() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Tw�j ma��onek nie znajduje sie blisko siebie.")
				say("")
				npc.unlock()
				return
			end -- if
			local ok_sign = confirm(u_vid, "Czy chcesz wzi�� �lub z"..pc.name.. "?", 30)
			if ok_sign != CONFIRM_OK then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Druga osoba nie zaakceptowa�a �lubu!")
				say("")
				npc.unlock()
				return
			end -- if
			say("")
			marriage.set_to_marriage()
			say("")
			say_reward("Obr�czki zosta�y przypisane.")
			say_reward(" �lub zosta� zawarty.")
			say("")
			npc.unlock()
		end -- when

		function give_wedding_gift()
			local male_item = {71072, 71073, 71074}
			local female_item = {71069, 71070, 71071}
			if pc.get_sex() == MALE then
				pc.give_item2(male_item[number(1, 3)], 1)
			else
				pc.give_item2(female_item[number(1, 3)], 1)
			end -- if
		end -- function

		when 9011.chat."Wystartuj Muzyk� " with (pc.is_engaged() or pc.is_married()) and marriage.in_my_wedding() and not marriage.wedding_is_playing_music() begin
			marriage.wedding_music(true, "wedding.mp3")
			setskin(NOWINDOW)
		end -- when

		when 9011.chat." Zatrzymaj Muzyk� " with (pc.is_engaged() or pc.is_married()) and marriage.in_my_wedding() and marriage.wedding_is_playing_music() begin
			marriage.wedding_music(false, "default")
			setskin(NOWINDOW)
		end -- when

		when 9011.chat."W��cz Noc" with pc.is_married() and marriage.in_my_wedding() begin
			marriage.wedding_dark(true)
			setskin(NOWINDOW)
		end -- when

		when 9011.chat."W��cz �nieg" with pc.is_married() and marriage.in_my_wedding() begin
			marriage.wedding_snow(true)
			setskin(NOWINDOW)
		end -- when

		when 9011.chat."Zako�cz �lub" with pc.is_married() and marriage.in_my_wedding() begin
			if not npc.lock() then
				say("Helen:")
				say("Czy chcesz przerwa� �lub?")
				say("")
				return
			end -- if
			say("Helen:")
			say("Czy chcesz naprawd� przerwa� ceremoni�?")
			say("")
			local s = select("Tak","Nie")
			if s == 1 then
				local u_vid = marriage.find_married_vid()
				if u_vid == 0 then
					say("Przerwa� cenemonie osoba musi by� na")
					say("tym �lubie. Musi to potwierdzi�.")
					say("")
					npc.unlock()
					return
				end -- if
				say("Helen:")
				say("Aby wzi��� �lub")
				say("tw�j partner musi podj�� decyzj�.")
				say("Czekam na odpowied�...")
				say("")
				local ok_sign = confirm(u_vid, "Czy chcesz zako�czy� wesele?", 30)
				if ok_sign == CONFIRM_OK then
					marriage.end_wedding()
				else
					say("Wesele nie zosta�o przerwane.")
					say("Druga osoba nie zgodzi�a si� na �lub.")
					say("")
				end -- if
			end -- if
			npc.unlock()
		end -- when

		when 11000.chat."Rozw�d Dwustronny" or 11002.chat."Rozw�d Dwustronny" or 11004.chat."Rozw�d Dwustronny" with pc.is_married() begin
			-- if not Marriage_Manage.check_divorce_time() then
			-- 	return
			-- end -- if
			local u_vid = marriage.find_married_vid()
			if u_vid == 0 or not npc.is_near_vid(u_vid, 10) then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Rozw�d to bardzo odpowiedzialna decyzja!")
				say("Je�li chcesz si� rozwie��,")
				say("tw�j partner musi by� zalogowany.")
				say("")
				return
			end -- if
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Rozw�d b�dzie kosztowa� 500.000 Yang.")
			say("Dodadkowo druga osoba musi si� zgodzi�.")
			say("Czy na pewno chcesz wzi�� �lub?")
			say("")
			local MONEY_NEED_FOR_ONE = 500000
			local s = select("Tak", "Nie")
			if s == 1 then
				local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
				local m_have_ring = pc.countitem(70302) > 0
				local old = pc.select(u_vid)
				local u_enough_money = pc.gold > MONEY_NEED_FOR_ONE
				local u_have_ring = pc.countitem(70302) > 0
				pc.select(old)
				if not m_have_ring then
					say("Musisz przynie�� obr�czk�.")
					return
				end -- if
				if not u_have_ring then
					say("Druga osoba musi przynie�� obr�czk�.")
					return
				end -- if
				if not m_enough_money then
					say("Stra�nik Wsi:")
					say("Nie masz wystarczaj�cej ilo�ci Yang, aby wzi��� rozw�d.")
					say("")
					say_reward(string.format("Potrzebujesz %s aby wzi��� rozw�d", MONEY_NEED_FOR_ONE/10000))
					say("")
					return
				end -- if
				if not u_enough_money then
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Druga osoba nie ma wystarczaj�cej ilo�ci Yang.")
					say("")
					say_reward("Aby wzi��� rozw�d oboje musicie mie� 500.00 Yang")
					say("")
					return
				end -- if
				say("Rozw�d jest bardzo bolesn� rzecz�,")
				say("czy na pewno chcesz si� rozwie��?")
				say("")
				local c=select("Tak", "Nie")
				if 2 == c then
					say_pc_name()
					say("Chc� rozwodu.")
					say("Taka jest moja decyzja.")
					say("")
					wait()
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Niech tak b�dzie...")
					say("Nie jeste�cie ju� par� ")
					say("Mo�ecie dalej cieszy� si� �yciem.")
					say("")
					say_reward("Rozw�d zako�czy� si� powodzeniem.")
					say("")
					return
				end -- if
				local ok_sign = confirm(u_vid, pc.name.." chce wzi�� rozw�d?", 30)
				if ok_sign == CONFIRM_OK then
					local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
					local m_have_ring = pc.countitem(70302) > 0
					local old = pc.select(u_vid)
					local u_enough_money = pc.gold > MONEY_NEED_FOR_ONE
					local u_have_ring = pc.countitem(70302) > 0
					pc.select(old)
					if m_have_ring and m_enough_money and u_have_ring and u_enough_money then
						pc.removeitem(70302, 1)
						pc.change_money(-MONEY_NEED_FOR_ONE)
						local old = pc.select(u_vid)
						pc.removeitem(70302, 1)
						pc.change_money(-MONEY_NEED_FOR_ONE)
						pc.select(old)
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Rozw�d zako�czony powodzeniem.")
						say("Jeste�cie r�nymi osobami,")
						say("nie mo�na was zmieni�.")
						say("")
						say_reward("Rozw�d zako�czony pomy�lnie!")
						say("")
						marriage.remove()
					else
						text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
						say("_____________________________________________________")
						say("Wyst�pi� b��d")
						say("Nie mo�ecie si� rozwie��.")
						say("Spr�bujcie potem.")
						say("")
						say_reward("Nie mo�na si� teraz rozwie��.")
						say("")
					end -- if
				else
					text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
					say("_____________________________________________________")
					say("Druga osoba si� nie godzi na rozw�d.")
					say("Je�li j� przekonasz")
					say("daj mi zna�.")
					say("")
					say_reward("Rozw�d odwo�any.")
					say("")
				end -- if
			end -- if
		end -- when

		when 11000.chat."Usu� Obr�czk� " or 11002.chat."Usu� Obr�czk� " or 11004.chat."Usu� Obr�czk� " with not pc.is_married() and pc.count_item(70302)>0 begin
		text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
		say("_____________________________________________________")
			say("Masz z�� wspomnienia...")
			say("Wszystko rozumiem.")
			say("")
			say_reward("Obr�czki zosta�y zniszczone.")
			pc.remove_item(70302)
		end -- when

		when 11000.chat." Rozw�d Jednostronny" or 11002.chat." Rozw�d Jednostronny" or 11004.chat." Rozw�d Jednostronny" with pc.is_married() begin
			-- if not Marriage_Manage.check_divorce_time() then
			-- 	return
			-- end -- if
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Jednostronny rozw�d kosztuje a� 1 Milion.")
			say("Chcesz zap�aci�?")
			say("")
			local s = select("P�ac� ", "Nie zap�ac� ")
			local NEED_MONEY = 1000000
			if s == 2 then
				return
			end -- if
			if pc.money < NEED_MONEY then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nie masz wystarczaj�cej ilo�ci Yang.")
				say("To za drogie?")
				say("Przyjd� jak zdob�dziesz pieni�dze.")
				say("")
				return
			end -- if
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Czy na pewno chcesz wzi�� rozw�d?")
			say("")
			local c = select("Chc� rozwodu!", "Nie chc� rozwodu!")
			if c == 2 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Dobra decyzja, ciesz si�...")
				say("Mo�e mi�o�� si� narodzi ponownie...")
				say("Dwie osoby maj� r�ne pogl�dy.")
				say("")
				say_reward("Rozw�d odwo�any")
				say("")
				return
			end -- if
			pc.removeitem(70302, 1)
			pc.change_gold(-NEED_MONEY)
			marriage.remove()
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Oby to by�a dobra decyzja")
			say("Jeste� teraz rozwiedzony.")
			say("Mam nadziej�, �e jeste� szcz�liwy.")
			say("")
			say_reward("Jednostronny rozw�d powi�d� si�.")
			say("")
		end -- when

		when oldwoman.chat." Lista �lub�w" with not pc.is_engaged() begin
			local t = marriage.get_wedding_list()
			if table.getn(t) == 0 then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("W tej chwili nie odbywa si� �aden �lub.")
				say("")
			else
				local wedding_names = {}
				table.foreachi(t,function(n, p) wedding_names[n] = p[3] .. " z " .. p[4] .. " " end) -- end
				wedding_names[table.getn(t)+1] = locale.confirm
				local s = select_table(wedding_names)
				if s != table.getn(wedding_names) then
					marriage.join_wedding(t[s][1], t[s][2])
				end -- if
			end -- if
		end -- when

		when 9011.click with not pc.is_engaged() and not pc.is_married() begin
			text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
			say("_____________________________________________________")
			say("Wszyscy przyszli�my tutaj aby �wi�towa�!")
			say("Wesele si� rozpocz�o! Para zosta�a ")
			say("pob�ogos�awiona!")
			say("")
		end -- when

		function check_divorce_time()
			local DIVORCE_LIMIT_TIME = 86400
			if is_test_server() then
				DIVORCE_LIMIT_TIME = 60
			end -- if

			if marriage.get_married_time() < DIVORCE_LIMIT_TIME then
				say("Nie mo�esz jeszcze wzi�� �lubu.")
				say("")
				return false
			end -- if
			return true
		end -- function

		function is_equip_wedding_dress()
			local a = pc.get_armor()
			return a >= 11901 and a <= 11904
		end -- function

		function get_wedding_dress(pc_job)
			if 0 == pc_job then
				return 11901
			elseif 1 == pc_job then
				return 11903
			elseif 2 == pc_job then
				return 11902
			elseif 3 == pc_job then
				return 11904
			else
				return 0
			end -- if
		end -- function
	end -- state
end -- quest
