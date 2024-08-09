define Kawalek_Zielonego_Kamienia 170201
define Kawalek_Niebieskiego_Kamienia 170202
define Kawalek_Pomaranczowego_Kamienia 170203
define Kawalek_Fioletowego_Kamienia 170204

define Krysztal_Szmaragdu 170205
define Krysztal_Szafiru 170206
define Krysztal_Granatu 170207
define Krysztal_Turmalinu 170208

define Bialy_Kawalek_Perly 170211
define Niebieski_Kawalek_Perly 170212
define Krwawy_Kawalek_Perly 170213

define Biala_Perla 27992
define Niebieska_Perla 27993
define Krwawa_Perla 27994

define Kawalek_Kamienia_Need_Count 10
define Kawalek_Perly_Need_Count 10

quest Item_Exchange begin
	state start begin
		when Kawalek_Zielonego_Kamienia.pick or Kawalek_Zielonego_Kamienia.use begin
			if pc.count_item(Kawalek_Zielonego_Kamienia) >= Kawalek_Kamienia_Need_Count then	
				pc.remove_item(Kawalek_Zielonego_Kamienia, Kawalek_Kamienia_Need_Count)
				pc.give_item2(Krysztal_Szmaragdu)
			end -- if
		end -- when

		when Kawalek_Niebieskiego_Kamienia.pick or Kawalek_Niebieskiego_Kamienia.use begin
			if pc.count_item(Kawalek_Niebieskiego_Kamienia) >= Kawalek_Kamienia_Need_Count then	
				pc.remove_item(Kawalek_Niebieskiego_Kamienia, Kawalek_Kamienia_Need_Count)
				pc.give_item2(Krysztal_Szafiru)
			end -- if
		end -- when

		when Kawalek_Pomaranczowego_Kamienia.pick or Kawalek_Pomaranczowego_Kamienia.use begin
			if pc.count_item(Kawalek_Pomaranczowego_Kamienia) >= Kawalek_Kamienia_Need_Count then	
				pc.remove_item(Kawalek_Pomaranczowego_Kamienia, Kawalek_Kamienia_Need_Count)
				pc.give_item2(Krysztal_Granatu)
			end -- if
		end -- when

		when Kawalek_Fioletowego_Kamienia.pick or Kawalek_Fioletowego_Kamienia.use begin
			if pc.count_item(Kawalek_Fioletowego_Kamienia) >= Kawalek_Kamienia_Need_Count then	
				pc.remove_item(Kawalek_Fioletowego_Kamienia, Kawalek_Kamienia_Need_Count)
				pc.give_item2(Krysztal_Turmalinu)
			end -- if
		end -- when

		when Bialy_Kawalek_Perly.pick or Bialy_Kawalek_Perly.use begin
			if pc.count_item(Bialy_Kawalek_Perly) >= Kawalek_Perly_Need_Count then	
				pc.remove_item(Bialy_Kawalek_Perly, Kawalek_Perly_Need_Count)
				pc.give_item2(Biala_Perla)
			end -- if
		end -- when

		when Niebieski_Kawalek_Perly.pick or Niebieski_Kawalek_Perly.use begin
			if pc.count_item(Niebieski_Kawalek_Perly) >= Kawalek_Perly_Need_Count then	
				pc.remove_item(Niebieski_Kawalek_Perly, Kawalek_Perly_Need_Count)
				pc.give_item2(Niebieska_Perla)
			end -- if
		end -- when

		when Krwawy_Kawalek_Perly.pick or Krwawy_Kawalek_Perly.use begin
			if pc.count_item(Krwawy_Kawalek_Perly) >= Kawalek_Perly_Need_Count then	
				pc.remove_item(Krwawy_Kawalek_Perly, Kawalek_Perly_Need_Count)
				pc.give_item2(Krwawa_Perla)
			end -- if
		end -- when
	end -- state
end -- quest
