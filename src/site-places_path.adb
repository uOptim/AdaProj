with Ada.Text_IO;

package body Site.Places_Path is

	function Open(From: In_Place; To: Out_Place) return Object is
		type Next_Place_Func is access
			function(R: Ring_Place) return Ring_Place;

		O: Object;
		F: Next_Place_Func;

		Ring_First: Ring_Place
			:= Ring_Place'(From - In_Place'First  + Ring_Place'First);
		Ring_Last:  Ring_Place
			:= Ring_Place'(To   - Out_Place'First + Ring_Place'First);

		C: Ring_Place := Ring_First;

	begin
		-- In Place and first Ring place
		Places_List.Push_Back(O.PP, From);
		Places_List.Push_Back(O.PP, Ring_First);

		-- Add ring places
		if Ring_First = Opposite(Ring_Last) then
			declare
				Center: Place_Name := Ring_Place'Last;
			begin
				Places_List.Push_Back(O.PP, Center);
				Places_List.Push_Back(O.PP, Ring_Last);
			end;
		else
			if Ring_First < Ring_Last then
				if (Ring_Last - Ring_First) <= NPlaces/2
				then F := Next'Access;
				else F := Prev'Access;
				end if;
			elsif Ring_First > Ring_Last then
				if (Ring_First - Ring_Last) >= NPlaces/2
				then F := Next'Access;
				else F := Prev'Access;
				end if;
			end if;

			while C /= Ring_Last loop
				C := F(C);
				Places_List.Push_Back(O.PP, C);
			end loop;
		end if;

		-- Out place
		Places_List.Push_Back(O.PP, To);

		O.It := 1;

		return O;
	end;


	procedure Close(O: in out Object) is
	begin
		O.It := 1;
		Places_List.Clear(O.PP);
	end;


	function Get_Path(O: Object) return Path.Object is
		Pl: Place;
		P:  Path.Object;
		I:  Places_Iterator.It;

		use type Path.Object;
		use type Places_Iterator.It;
	begin
		Places_Iterator.Init_Front(I, O.PP);
		loop
			Pl := Places(Places_Iterator.Get(I));
			P  := P & Path.Point'(Float(Pl.X), Float(Pl.Y));
			exit when (not Places_Iterator.Has_Next(I));
			I  := I+1;
		end loop;
		return P;
	end;


	function At_End(O: Object) return Boolean is
		(O.It = Places_List.Size(O.PP));


	function Robot_Intersects(P: Ring_Place; R: Bot_ID) return Boolean is
		Square_Dist: Float;
		Rbt_Pos:     Position := Positions(R);
	begin
		-- use last reported robot position
		Square_Dist :=
			  (Float(Places(P).X) - Float(Rbt_Pos.X))**2
			+ (Float(Places(P).Y) - Float(Rbt_Pos.Y))**2;
		return Square_Dist <= Place_Size**2;
	end;
end;

