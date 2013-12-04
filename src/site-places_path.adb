
package body Site.Places_Path is

	function Open(From, To: Place_ID) return Object is
		type Next_Place_Func is access
			function(R: Ring_Place) return Ring_Place;

		C:  Ring_Place := RP(From);
		F:  Next_Place_Func;
		PP: Path.Object;

	begin
		Path.Add(PP, Path.Point'(Float(C.X), Float(C.Y)));

		if To = Opposite(RP(From)).ID then
			Path.Add(PP, Path.Point'(Float(Center.X), Float(Center.Y)));
			Path.Add(PP, Path.Point'(Float(RP(To).X), Float(RP(To).Y)));
		else
			if From < To then
				if ((To - From) <= Place_ID'Last/2) then
					F := Next'Access;
				else
					F := Prev'Access;
				end if;
			elsif From > To then
				if ((From - To) >= Place_ID'Last/2) then
					F := Next'Access;
				else
					F := Prev'Access;
				end if;
			end if;

			while C.ID /= To loop
				C := F(C);
				Path.Add(PP, Path.Point'(Float(C.X), Float(C.Y)));
			end loop;
		end if;

		return Object'(P => PP, It => 1);
	end;


	function Get_Path(PP: Object) return Path.Object is
		(PP.P);


	function At_End(PP: Object) return Boolean is
		(Path.Segment_Count(PP.P) = PP.It-1);


	function Robot_Intersects(P: Place_ID; R: Bot_ID) return Boolean is
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

