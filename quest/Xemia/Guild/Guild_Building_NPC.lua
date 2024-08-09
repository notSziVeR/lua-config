quest Guild_Building_NPC begin
	state start begin
		when 20044.click begin
			if npc.get_guild() == pc.get_guild() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Och! Jeste� cz�onkiem mojej gildii!")
				say("Je�li chcesz ulepszy� bro�, powiniene� j� ")
				say("przynie�� do mnie a nie do tego amatora z wioski.")
				say("Szanse na powodzenie s� u mnie o 10% wy�sze.")
				say("Cz�onkom gildii oferuj� poza tym 5% zni�ki. Po")
				say("prostu daj mi bro�, kt�r� chcesz ulepszy�, a ja")
				say("ju� o to zadbam.")
				say("")
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazywam si� Stanley. Jestem odpowiedzialny za")
				say("ulepszanie broni. Jestem w tym du�o lepszy od")
				say("Kowala z miasta! Je�li spr�bujesz ulepszy� u mnie")
				say("bro�, szansa na powodzenie b�dzie zwi�kszona o")
				say("10%. Daj mi bro�, kt�r� chcesz ulepszy�.")
				say("")
			end -- if
		end -- when

		when 20045.click begin
			if npc.get_guild() == pc.get_guild() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Och, jeste� cz�onkiem mojej gildii! W takim razie")
				say("mo�esz powierzy� mi ulepszenie swojej zbroi,")
				say("swoich tarcz, he�m�w oraz swojego obuwia. Szanse")
				say("na powodzenie s� u mnie o 10% wy�sze ni� u kowala")
				say("z wioski! Opr�cz tego oferuj� 5% zni�k� dla")
				say("wszystkich cz�onk�w mojej gildii. Po prostu daj")
				say("zbroj�, kt�r� chcesz ulepszy�.")
				say("")
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazywam si� Stanton, jestem odpowiedzialny za")
				say("ulepszanie zbroi, co wychodzi mi znacznie lepiej")
				say("ni� kowalowi z wioski. Szanse na powodzenie s� u")
				say("mnie o 10% wy�sze! Po prostu daj mi zbroj�, kt�r� ")
				say("chcesz ulepszy�.")
				say("")
			end -- if
		end -- when

		when 20046.click begin
			if npc.get_guild() == pc.get_guild() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Oh! Jeste� cz�onkiem mojej gildii!")
				say("Szansa na pomy�lne ulepszenie b�dzie zwi�kszona o")
				say("10% je�eli zdecydujesz si� spr�bowa� ulepszy� u")
				say("mnie swoje akcesoria. Cz�onkowie naszej gildii")
				say("maj� zni�k� 5%.")
				say("Daj mi przedmiot, kt�ry chcesz ulepszy�.")
				say("")
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazywam si� Starbuck, jestem odpowiedzialny za")
				say("ulepszanie bi�uterii. Jestem w tym du�o lepszy od")
				say("Kowala z miasta! Je�li spr�bujesz ulepszy� u mnie")
				say("swoje akcesoria, szansa na powodzenie b�dzie")
				say("zwi�kszona o 10%. Mog� ulepsza� bransoletki,")
				say("kolczyki i buty. Daj mi przedmiot, kt�ry chcesz")
				say("ulepszy�.")
				say("")
			end -- if
		end -- when
	end -- state
end -- quest
