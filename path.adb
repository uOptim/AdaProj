--with Ada.Numerics.Generic_Elementary_Functions;

package body Path is
	--package GEF is new Ada.Numerics.Generic_Elementary_Functions(Float);

	function Value(From: Points) return Object is
		Obj: Object(Size => From'Length);
	begin
		Obj.Values := From;
		return Obj;
	end Value;

	function Segment_Count(Path: in Object) return Natural is
		(Path.Values'Length - 1);

	function Segment_Length(Path: in Object; Segment: in Positive)
		return Natural is
		P1: Point := Path.Values(Segment  );
		P2: Point := Path.Values(Segment+1);
	begin
		-- TODO
		return 0;
	end;

	function "&"(Left: in Object; Right: in Object) return Object is
		Obj: Object(Left.Size + Right.Size);
	begin
		Obj.Values(1           .. Left.Size ) := Left.Values;
		Obj.Values(Left.Size+1 .. Right.Size) := Right.Values;
		return Obj;
	end;

	function "&"(Left: in Object; Right: in Point) return Object is
		Obj: Object(Left.Size+1);
	begin
		Obj.Values(Obj.Size)     := Right;
		Obj.Values(1..Left.Size) := Left.Values;
		return Obj;
	end;

	function "&"(Left: in Point ; Right: in Object) return Object is
		(Right & Left);

	procedure Add(Path: in out Object; P: in Point) is
	begin
		Path.Values := Path.Values & P;
	end;
end Path;
