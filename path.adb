with Ada.Numerics.Generic_Elementary_Functions;

package body Path is
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
		(Right & Left);

	procedure Add(Path: in out Object; P: in Point) is
	begin
		Path.Values := Path.Values & P;
	end;
end Path;
