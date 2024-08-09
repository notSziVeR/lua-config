quest Drop_Metin begin
	state start begin
		when kill with !npc.is_pc() begin
			local Level = pc.get_level();
			local Mob_Level = npc.get_level0();
			local Rand = math.random(100);
			local Rand_Item = math.random(4);
			local Rand_Item2 = math.random(3);
			local Rand_Item3 = math.random(5);
			local Chance = 100;
			local Chance_Book_02 = 100;
			local Chance_Piece_Pearl = 100;

			if npc.get_race() >= 8001 and npc.get_race() <= 8014 or npc.get_race() == 8070 then
				if Rand < Chance then
					if Level - Mob_Level <= 15 and Level - Mob_Level >= -50 then
						if (is_test_server()) or pc.is_gm() then
							syschat(string.format("[Book]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item, Chance));
						end -- if
						if Rand_Item == 1 then
							game.drop_item_with_ownership(170001, 1); -- Skrzynia Ksi�g Wojownika
						elseif Rand_Item == 2 then
							game.drop_item_with_ownership(170002, 1); -- Skrzynia Ksi�g Ninji
						elseif Rand_Item == 3 then
							game.drop_item_with_ownership(170003, 1); -- Skrzynia Ksi�g Szamana
						elseif Rand_Item == 4 then
							game.drop_item_with_ownership(170004, 1); -- Skrzynia Ksi�g Sury
						end -- if
					end -- if
				end -- if
			end -- if

			if npc.get_race() == 8014 then
				if Rand < Chance_Book_02 then
					if Level - Mob_Level <= 15 and Level - Mob_Level >= -50 then
						if (is_test_server()) or pc.is_gm() then
							syschat(string.format("[Book_02]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item, Chance_Book_02));
						end -- if
						if Rand_Item == 1 then
							game.drop_item_with_ownership(170001, 1); -- Skrzynia Ksi�g Wojownika
						elseif Rand_Item == 2 then
							game.drop_item_with_ownership(170002, 1); -- Skrzynia Ksi�g Ninji
						elseif Rand_Item == 3 then
							game.drop_item_with_ownership(170003, 1); -- Skrzynia Ksi�g Szamana
						elseif Rand_Item == 4 then
							game.drop_item_with_ownership(170004, 1); -- Skrzynia Ksi�g Sury
						end -- if
					end -- if
				else
					if (is_test_server()) or pc.is_gm() then
						syschat(string.format("[Book_02]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance_Book_02));
					end -- if
				end -- if
			end -- if

			if npc.get_race() == 8014 or npc.get_race() >= 8024 and npc.get_race() <= 8027 then
				if Rand < Chance_Piece_Pearl then
					if Level - Mob_Level <= 15 and Level - Mob_Level >= -50 then
						if (is_test_server()) or pc.is_gm() then
							syschat(string.format("[Kawa�ek Per�y]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance_Piece_Pearl));
						end -- if
						if Rand_Item2 == 1 then
							game.drop_item_with_ownership(170211, 1); -- Bia�y Kawa�ek Per�y
						elseif Rand_Item2 == 2 then
							game.drop_item_with_ownership(170212, 1); -- Niebieski Kawa�ek Per�y
						elseif Rand_Item2 == 3 then
							game.drop_item_with_ownership(170213, 1); -- Krwawy Kawa�ek Per�y
						end -- if
					end -- if
				else
					if (is_test_server()) or pc.is_gm() then
						syschat(string.format("[Kawa�ek Per�y]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance_Piece_Pearl));
					end -- if
				end -- if
			end -- if

			if npc.get_race() == 693 or npc.get_race() == 2191 or npc.get_race() == 792 
			or npc.get_race() == 1304 or npc.get_race() == 1901 or npc.get_race() == 2091 or npc.get_race() == 2206 
			or npc.get_race() == 2306 or npc.get_race() == 2307 then
				if Rand < Chance then
					if Level - Mob_Level <= 15 and Level - Mob_Level >= -50 then
						if (is_test_server()) or pc.is_gm() then
							syschat(string.format("[Kawa�ek Per�y]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance));
						end -- if
						if Rand_Item2 == 1 then
							game.drop_item_with_ownership(170211, 2); -- Bia�y Kawa�ek Per�y
						elseif Rand_Item2 == 2 then
							game.drop_item_with_ownership(170212, 2); -- Niebieski Kawa�ek Per�y
						elseif Rand_Item2 == 3 then
							game.drop_item_with_ownership(170213, 2); -- Krwawy Kawa�ek Per�y
						end -- if
					end -- if
				else
					if (is_test_server()) or pc.is_gm() then
						syschat(string.format("[Kawa�ek Per�y]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance));
					end -- if
				end -- if
			end -- if

			if npc.get_race() == 1093 then
				if Rand < Chance then
					if Level - Mob_Level <= 15 and Level - Mob_Level >= -50 then
						if (is_test_server()) or pc.is_gm() then
							syschat(string.format("[Kawa�ek Per�y]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance));
						end -- if
						if Rand_Item2 == 1 then
							game.drop_item_with_ownership(170211, 5); -- Bia�y Kawa�ek Per�y
						elseif Rand_Item2 == 2 then
							game.drop_item_with_ownership(170212, 5); -- Niebieski Kawa�ek Per�y
						elseif Rand_Item2 == 3 then
							game.drop_item_with_ownership(170213, 5); -- Krwawy Kawa�ek Per�y
						end -- if
					end -- if
				else
					if (is_test_server()) or pc.is_gm() then
						syschat(string.format("[Kawa�ek Per�y]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance));
					end -- if
				end -- if
			end -- if

			if npc.get_race() == 2092 or npc.get_race() == 2598 or npc.get_race() == 2493 then
				if Rand < Chance then
					if Level - Mob_Level <= 15 and Level - Mob_Level >= -50 then
						if (is_test_server()) or pc.is_gm() then
							syschat(string.format("[Pearl]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance));
						end -- if
						if Rand_Item2 == 1 then
							game.drop_item_with_ownership(27992, 1); -- Bia�a Per�a
						elseif Rand_Item2 == 2 then
							game.drop_item_with_ownership(27993, 1); -- Niebieska Per�a
						elseif Rand_Item2 == 3 then
							game.drop_item_with_ownership(27994, 1); -- Krwawa Per�a
						end -- if
					end -- if
				else
					if (is_test_server()) or pc.is_gm() then
						syschat(string.format("[Pearl]: Level: %d, Mob Level: %d, Rand: %d, Rand Item: %d, Chance: %d", Level, Mob_Level, Rand, Rand_Item2, Chance));
					end -- if
				end -- if
			end -- if
		end -- when
	end -- state
end -- quest
