quest Skrzynia_Referencji begin
	state start begin
		when 170801.use begin
			if false == pc.can_warp() then
				syschat("Musisz odczeka� 10 sekund zanim to zrobisz.")
				return 
			end -- if

			pc.remove_item(170801, 1);

			if pc.get_sex() == 0 then
				pc.give_item2(42017, 1) -- Szata �owc�w Demon�w (M)
				pc.give_item2(46017, 1) -- Fryzura �owc�w Demon�w (M)
			else
				pc.give_item2(42018, 1) -- Szata �owc�w Demon�w (F)
				pc.give_item2(46018, 1) -- Fryzura �owc�w Demon�w (F)
			end -- if
		end -- when
	end -- state
end -- quest
