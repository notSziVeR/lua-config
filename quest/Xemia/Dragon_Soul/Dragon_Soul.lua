define Dragon_Stone_Shard 30270
define Dragon_Stone_Shard_Need_Count 10
define Cor_Draconis_Rough 50255

quest Dragon_Soul begin
	state start begin
		when Dragon_Stone_Shard.pick or Dragon_Stone_Shard.use begin
			if pc.count_item(Dragon_Stone_Shard) >= Dragon_Stone_Shard_Need_Count then	
				pc.remove_item(Dragon_Stone_Shard, Dragon_Stone_Shard_Need_Count);
				pc.give_item2(Cor_Draconis_Rough);
			end -- if
		end -- when
	end -- state
end -- quest
