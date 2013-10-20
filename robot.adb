with Path;
with Adagraph;

with Ada.Text_IO;


package body Robot is
	package IO renames Ada.Text_IO;

	task body Object is
		Pos: Position;
		P:   Path.Object;

		K: Float    := 0.0; -- Param
		S: Positive := 1;   -- Segment number
		X, Y: Float;        -- Position from Path.X() and Path.Y()
	begin
		loop
			select
				accept Follow(PP: in Path.Object) do
					P := PP;
					S := 1;
					K := 0.0;
					if Path.Segment_Count(P) > 0 then
						X := Path.X(P, S, K);
						Y := Path.Y(P, S, K);
					else
						X := 0.0;
						Y := 0.0;
					end if;
					Pos := Position'(Integer(X), Integer(Y));
				end;
			or
				accept Tick do
					K := K + dK;
					if K > 1.0 then
						K := 0.0;
						if S < Path.Segment_Count(P) then
							S := S + 1;
						else
							S := 1;  -- restart from the begining!
						end if;
						IO.Put_Line("segment #" & Integer'Image(S));
					end if;
					X   := Path.X(P, S, K);
					Y   := Path.Y(P, S, K);
					Pos := Position'(Integer(X), Integer(Y));
				end;
			or
				accept Get_Pos(PP: out Position) do
					PP := Pos;
				end;
			or
				accept Shutdown do
					IO.Put_Line("Robot shuting down");
				end;
				exit;
			end select;
		end loop;
	end;

end;
