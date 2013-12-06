with Ada.Text_IO;

package body Site.Places_Path is

	function Open(From, To: Ring_Place) return Object is
		type Next_Place_Func is access
			function(R: Ring_Place) return Ring_Place;

		O: Object;
		C: Ring_Place := From;
		F: Next_Place_Func;

	begin
		if (O.PP /= null) then
			Close(O);
		end if;

		O.It := 1;
		O.PP := new Places_List.Object;

		Places_List.Push_Back(O.PP.all, RP(C));

		if To = Opposite(From) then
			declare
				Center: Place := RP(Ring_Place'Last);
			begin
				Places_List.Push_Back(O.PP.all, Center);
				Places_List.Push_Back(O.PP.all, RP(To));
			end;
		else
			if From < To then
				if (To - From) <= NPlaces/2
				then F := Next'Access;
				else F := Prev'Access;
				end if;
			elsif From > To then
				if (From - To) >= NPlaces/2
				then F := Next'Access;
				else F := Prev'Access;
				end if;
			end if;

			while C /= To loop
				C := F(C);
				Places_List.Push_Back(O.PP.all, RP(C));
			end loop;
		end if;

		return O;
	end;


	procedure Close(O: in out Object) is
	begin
		if (O.PP /= null) then
			Free_PP(O.PP);
			O.PP := null;
		end if;
		O.It := 1;
	end;


	function Get_Path(O: Object) return Path.Object is
		Pl: Place;
		P:  Path.Object;
		I:  Places_Iterator.It;

		use type Path.Object;
		use type Places_Iterator.It;
	begin
		Places_Iterator.Init_Front(I, O.PP.all);
		loop
			Pl := Places_Iterator.Get(I);
			P  := P & Path.Point'(Float(Pl.X), Float(Pl.Y));
			exit when (not Places_Iterator.Has_Next(I));
			I  := I+1;
		end loop;
		return P;
	end;


	function At_End(O: Object) return Boolean is
		(O.It = Places_List.Size(O.PP.all));


	function Robot_Intersects(P: Ring_Place; R: Bot_ID) return Boolean is
		Square_Dist: Float;
		Rbt_Pos:     Position := Positions(R);
	begin
		-- use last reported robot position
		Square_Dist :=
			  (Float(RP(P).X) - Float(Rbt_Pos.X))**2
			+ (Float(RP(P).Y) - Float(Rbt_Pos.Y))**2;
		return Square_Dist <= Place_Size**2;
	end;
end;

