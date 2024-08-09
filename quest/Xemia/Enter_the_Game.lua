quest Enter_the_Game begin
	state start begin
		when login with pc.getqf("Complete_Login") == 0 and pc.get_level() == 1 and pc.get_exp() == 0 begin
			if pc.getqf("Complete_Login") == 0 and pc.get_level() == 1 and pc.get_exp() == 0 then
				horse.set_level(21);

				affect.add_collect(8, 30, 60 * 60 * 24 * 365 * 60); -- Pr�dko�c Ruchu

				pc.set_skill_level(122, 2); -- Kombinacja
				pc.set_skill_level(123, 1); -- �owienie
				pc.set_skill_level(124, 1); -- G�rnictwo
				pc.set_skill_level(126, 59); -- J�zyk Shinsoo
				pc.set_skill_level(127, 59); -- J�zyk Chunjo
				pc.set_skill_level(128, 59); -- J�zyk Jinno
				pc.set_skill_level(131, 10); -- Przywo�aj Konia
				pc.set_skill_level(147, 1); -- Jeweller

				pc.set_skill_level(137, 1); -- Ci�cie z Siod�a
				pc.set_skill_level(138, 1); -- St�pni�cie Konia
				pc.set_skill_level(139, 1); -- Fala Mocy
				if pc.job == 1 then -- Ninja
					pc.set_skill_level(140, 1); -- Grad Strza�
				end -- if

				pc.give_item2(72724, 1); -- Eliksir �ycia
				pc.give_item2(72728, 1); -- Eliksir Many
				pc.give_item2(173017, 1); -- Zielony Eliksir
				pc.give_item2(173018, 1); -- Fioletowy Eliksir
				pc.give_item2(70038, 1); -- Peleryna M�stwa
				pc.give_item2(71085, 1); -- Wzmocnienie Przedmiotu

				pc.give_item2(173001, 1); -- D�o� Krytyka (B)
				pc.give_item2(173002, 1); -- D�o� Przebicia (B)
				pc.give_item2(173003, 1); -- �ycie Boga Smok�w (B)
				pc.give_item2(173004, 1); -- Atak Boga Smok�w (B)
				pc.give_item2(173006, 1); -- Obrona Boga Smok�w (B)
				pc.give_item2(173066, 1); -- Bia�a Rosa

				pc.give_item2(180001, 1); -- Pier�cie� Z�otego Lwa
				pc.give_item2(180002, 1); -- Pier�cie� Leonidasa

				pc._instant_equip(13009); -- Bojowa Tarcza+9
				pc._instant_equip(14009); -- Drewniana Bransoleta+9
				pc._instant_equip(15009); -- Sk�rzane Buty+9
				pc._instant_equip(16009); -- Drewniany Naszyjnik+9
				pc._instant_equip(17009); -- Drewniane Kolczyki+9

				if pc.job == 0 then -- Wojownik
					pc._instant_equip(19); -- Miecz+9
					pc.give_item2(3009, 1); -- Glewia+9
					pc._instant_equip(11209); -- Mnisia Zbr. P�yt.+9
					pc._instant_equip(12209); -- Tradycyjny He�m+9
				end -- if

				if pc.job == 1 then -- Ninja
					pc._instant_equip(19); -- Miecz+6
					pc.give_item2(1009, 1); -- Sztylet+9
					pc.give_item2(2009, 1); -- �uk+9
					pc._instant_equip(11409); -- B��kitne Ubranie+9
					pc._instant_equip(12349); -- Sk�rzana Maska+9
				end -- if

				if pc.job == 2 then -- Sura
					pc._instant_equip(19); -- Miecz+9
					pc._instant_equip(11609); -- �a�obna Zbr. P�yt.+9
					pc._instant_equip(12489); -- Krwawy He�m+9
				end -- if

				if pc.job == 3 then -- Szaman
					pc._instant_equip(5009); -- Miedziany Dzwon+9
					pc.give_item2(7009, 1); -- Wachlarz+9
					pc._instant_equip(11809); -- B��kitna Szata+9
					pc._instant_equip(12629); -- Czapka Mnicha+9
				end -- if

				if pc.get_empire() == 1 then -- Shinsoo
					notice_all("[Shinsoo]: Player " .. pc.get_name() .. " started his adventure on Xemia.to.");
				elseif pc.get_empire() == 3 then -- Jinno
					notice_all("[Jinno]: Player " .. pc.get_name() .. " started his adventure on Xemia.to.");
				end -- if

				pc.setqf("Complete_Login", 1);
				set_state(Complete_Quest);
			end -- if
		end -- when
	end -- state

	state Complete_Quest begin
		when enter begin
			q.done();
		end -- when
	end -- state
end -- quest
