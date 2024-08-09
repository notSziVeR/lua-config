quest Guild_Building_NPC begin
	state start begin
		when 20044.click begin
			if npc.get_guild() == pc.get_guild() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Och! Jesteœ cz³onkiem mojej gildii!")
				say("Jeœli chcesz ulepszyæ broñ, powinieneœ j¹ ")
				say("przynieœæ do mnie a nie do tego amatora z wioski.")
				say("Szanse na powodzenie s¹ u mnie o 10% wy¿sze.")
				say("Cz³onkom gildii oferujê poza tym 5% zni¿ki. Po")
				say("prostu daj mi broñ, któr¹ chcesz ulepszyæ, a ja")
				say("ju¿ o to zadbam.")
				say("")
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazywam siê Stanley. Jestem odpowiedzialny za")
				say("ulepszanie broni. Jestem w tym du¿o lepszy od")
				say("Kowala z miasta! Jeœli spróbujesz ulepszyæ u mnie")
				say("broñ, szansa na powodzenie bêdzie zwiêkszona o")
				say("10%. Daj mi broñ, któr¹ chcesz ulepszyæ.")
				say("")
			end -- if
		end -- when

		when 20045.click begin
			if npc.get_guild() == pc.get_guild() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Och, jesteœ cz³onkiem mojej gildii! W takim razie")
				say("mo¿esz powierzyæ mi ulepszenie swojej zbroi,")
				say("swoich tarcz, he³mów oraz swojego obuwia. Szanse")
				say("na powodzenie s¹ u mnie o 10% wy¿sze ni¿ u kowala")
				say("z wioski! Oprócz tego oferujê 5% zni¿kê dla")
				say("wszystkich cz³onków mojej gildii. Po prostu daj")
				say("zbrojê, któr¹ chcesz ulepszyæ.")
				say("")
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazywam siê Stanton, jestem odpowiedzialny za")
				say("ulepszanie zbroi, co wychodzi mi znacznie lepiej")
				say("ni¿ kowalowi z wioski. Szanse na powodzenie s¹ u")
				say("mnie o 10% wy¿sze! Po prostu daj mi zbrojê, któr¹ ")
				say("chcesz ulepszyæ.")
				say("")
			end -- if
		end -- when

		when 20046.click begin
			if npc.get_guild() == pc.get_guild() then
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Oh! Jesteœ cz³onkiem mojej gildii!")
				say("Szansa na pomyœlne ulepszenie bêdzie zwiêkszona o")
				say("10% je¿eli zdecydujesz siê spróbowaæ ulepszyæ u")
				say("mnie swoje akcesoria. Cz³onkowie naszej gildii")
				say("maj¹ zni¿kê 5%.")
				say("Daj mi przedmiot, który chcesz ulepszyæ.")
				say("")
			else
				text_center() say_title(string.format("%s:", mob_name(npc.get_race())))
				say("_____________________________________________________")
				say("Nazywam siê Starbuck, jestem odpowiedzialny za")
				say("ulepszanie bi¿uterii. Jestem w tym du¿o lepszy od")
				say("Kowala z miasta! Jeœli spróbujesz ulepszyæ u mnie")
				say("swoje akcesoria, szansa na powodzenie bêdzie")
				say("zwiêkszona o 10%. Mogê ulepszaæ bransoletki,")
				say("kolczyki i buty. Daj mi przedmiot, który chcesz")
				say("ulepszyæ.")
				say("")
			end -- if
		end -- when
	end -- state
end -- quest
