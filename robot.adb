with Path;
with Adagraph;

with Ada.Text_IO;


package body Robot is
	package IO renames Ada.Text_IO;

	task body Object is
	begin
		loop
			select
				accept Follow(P: Path.Object) do
					Follow_Path(P);
				end;
			or
				accept Shutdown do
					IO.Put_Line("Robot shuting down");
				end;
				exit;
			end select;
		end loop;
	end;


	procedure Follow_Path(P: Path.Object) is
		K: Float;
		X, Y: Float;
	begin
		for i in Integer range 1 .. Path.Segment_Count(P) loop
			K := 0.0;
			IO.Put_Line("Robot following segment #" & Integer'Image(i));
			while K <= 1.0 loop
				X := Path.X(P, i, K);
				Y := Path.Y(P, i, K);
				IO.Put_Line(Float'Image(X) & ":" & Float'Image(Y));
				K := K + dK;
				delay dt;
			end loop;
		end loop;
	end;


end;
