with Adagraph;
with Ada.Numerics.Generic_Elementary_Functions;

package body Path is
	use Adagraph;
	package GEF is new Ada.Numerics.Generic_Elementary_Functions(Float);

	function Value(From: Points) return Object is
		Obj: Object(Size => From'Length);
	begin
		Obj.Values := From;
		return Obj;
	end Value;

	function Segment_Count(Path: in Object) return Natural is
		(if Path.Values'Length > 0 then Path.Values'Length - 1 else 0);

	function Segment_Length(Path: in Object; Segment: in Positive)
		return Float is
		P1: Point := Path.Values(Segment  );
		P2: Point := Path.Values(Segment+1);
	begin
		return GEF.Sqrt(
			  (P2.X - P1.X)*(P2.X - P1.X)
			+ (P2.Y - P1.Y)*(P2.Y - P1.Y)
		);
	end;

	function "&"(Left: in Object; Right: in Object) return Object is
		Obj: Object(Left.Values'Length + Right.Values'Length);
	begin
		Obj.Values := Left.Values & Right.Values;
		return Obj;
	end;

	function "&"(Left: in Object; Right: in Point) return Object is
		Obj: Object(Left.Values'Length+1);
	begin
		Obj.Values := Left.Values & Right;
		return Obj;
	end;

	function "&"(Left: in Point ; Right: in Object) return Object is
		Obj: Object(Right.Values'Length+1);
	begin
		Obj.Values := Points'(0 => Left) & Right.Values;
		return Obj;
	end;

	procedure Add(Path: in out Object; P: in Point) is
	begin
		-- TODO: very ineffective!
		-- double the array size each realloc instead when you got time
		Path := Path & P;
	end;

	procedure Draw(Path: in Object; Color: in Color_Type := Light_Green) is
		P_Prev: Point;
		Len:    Count := Path.Values'Length;
	begin
		if Len < 2 then return; end if;

		P_Prev := Path.Values(1);
		for P of Path.Values(2..Len) loop
			Draw_Line(
				Integer(P_Prev.X), Integer(P_Prev.Y),
				Integer(P.X),      Integer(P.Y),
				Color
			);
			P_Prev := P;
		end loop;
	end;

end Path;
