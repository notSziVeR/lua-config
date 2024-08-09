quest Skrzynia_Referencji begin
	state start begin
		when 170801.use begin
			if false == pc.can_warp() then
				syschat("Musisz odczekaæ 10 sekund zanim to zrobisz.")
				return 
			end -- if

			pc.remove_item(170801, 1);

			if pc.get_sex() == 0 then
				pc.give_item2(42017, 1) -- Szata £owców Demonów (M)
				pc.give_item2(46017, 1) -- Fryzura £owców Demonów (M)
			else
				pc.give_item2(42018, 1) -- Szata £owców Demonów (F)
				pc.give_item2(46018, 1) -- Fryzura £owców Demonów (F)
			end -- if
		end -- when
	end -- state
end -- quest
