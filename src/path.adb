with Adagraph;
with Ada.Numerics.Generic_Elementary_Functions;

with Ada.Text_IO;

package body Path is
	use Adagraph;
	package GEF is new Ada.Numerics.Generic_Elementary_Functions(Float);

	function Value(From: Points) return Object is
		Obj: Object(From'Length);
	begin
		Obj.Values := From;
		return Obj;
	end Value;


	function Segment_Count(Path: in Object) return Natural is
		(if Path.Size > 0 then Path.Size - 1 else 0);


	function Segment_Length(Path: in Object; Segment: in Positive)
		return Float is
		P1, P2: Point;
	begin
		if Path.Size > 1 then
			P1 := Path.Values(Segment  );
			P2 := Path.Values(Segment+1);
			return GEF.Sqrt(
				  (P2.X - P1.X)*(P2.X - P1.X)
				+ (P2.Y - P1.Y)*(P2.Y - P1.Y)
			);
		else
			return 0.0;
		end if;
	end;


	function "&"(Left: in Object; Right: in Object) return Object is
		Obj: Object(Left.Size + Right.Size);
	begin
		Obj.Values := Left.Values & Right.Values;
		return Obj;
	end;


	function "&"(Left: in Object; Right: in Point) return Object is
		Obj: Object(Left.Size+1);
	begin
		Obj.Values := Left.Values & Right;
		return Obj;
	end;


	function "&"(Left: in Point ; Right: in Object) return Object is
		Obj: Object(Right.Size+1);
	begin
		Obj.Values := Points'(0 => Left) & Right.Values;
		return Obj;
	end;


	procedure Add(Path: in out Object; P: in Point) is
	begin
		-- FIXME: very ineffective!
		Path := Path & P;
	end;


	function X(Path: in Object; Segment: in Positive; K: Parameter)
		return Float is
		X1, X2: Float;
	begin
		if Segment < Path.Values'Last then
			X1 := Path.Values(Segment  ).X;
			X2 := Path.Values(Segment+1).X;
			return X1 + K*(X2-X1);
		else
			X1 := Path.Values(Segment).X;
			return X1;
		end if;
	end;


	function Y(Path: in Object; Segment: in Positive; K: Parameter)
		return Float is
		Y1, Y2: Float;
	begin
		if Segment < Path.Values'Last then
			Y1 := Path.Values(Segment  ).Y;
			Y2 := Path.Values(Segment+1).Y;
			return Y1 + K*(Y2-Y1);
		else
			Y1 := Path.Values(Segment).Y;
			return Y1;
		end if;
	end;


	procedure Print(P: Object) is
	begin
		if P = Null_Path then
			Ada.Text_IO.Put_Line("Null path.");
			return;
		end if;

		for I in P.Values'Range loop
			Ada.Text_IO.Put(
				Float'Image(P.Values(I).X) &
				Float'Image(P.Values(I).Y) &
				","
			);
		end loop;
		Ada.Text_IO.Put_Line("");
	end;

end Path;
