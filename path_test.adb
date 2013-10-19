with Path;
with Ada.Text_IO;

procedure Path_Test is
	use Path;
	package IO renames Ada.Text_IO;

	ERROR: exception;
begin

	-- Basic path tests
	declare
		P: Object := Null_Path;
		Q: Object := Null_Path;
		A: Point := Point'(1.0, 2.0);
		B: Point := Point'(3.0, 2.0);
		C: Point := Point'(3.0, 3.0);
		Epsilon : Float := 0.01;
	begin
		IO.Put("Testing Path manipulation functions... ");

		-----------
		if Segment_Count(P) /= 0 then raise ERROR; end if;

		-----------
		Add(P, A);
		Add(P, B);

		if Segment_Count(P) /= 1 then raise ERROR; end if;

		if         Segment_Length(P, 1) < 2.0-Epsilon
		   or else Segment_Length(P, 1) > 2.0+Epsilon
		   then raise ERROR; end if;

		-----------
		P := P & C;
		P := A & P;
		if Segment_Count(P) /= 3 then raise ERROR; end if;

		-----------
		P := Value(A & B & C);
		if Segment_Count(P) /= 2 then raise ERROR; end if;

		-----------
		P := Value((0 => A));
		if Segment_Count(P) /= 0 then raise ERROR; end if;

		IO.Put_Line("OK.");
	end;

	-- drawing tests
	declare
	begin
		null;
	end;
end;
