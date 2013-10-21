with Path;
with Adagraph;

with Ada.Text_IO;
with Ada.Real_Time;


package body Robot is
	package IO renames Ada.Text_IO;
	package RT renames Ada.Real_Time;
	use type Ada.Real_Time.Time, Ada.Real_Time.Time_Span;

	task body Object is
		Pos: Position;
		P:   Path.Object;

		K: Float    := 0.0; -- Param
		S: Positive := 1;   -- Segment number
		X, Y: Float;        -- Position from Path.X() and Path.Y()

		Tick_Time, Next_Tick: RT.Time;
	begin
		Tick_Time := RT.Clock;
		Next_Tick := Tick_Time + RT.Milliseconds(dt);
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
				delay until Next_Tick;
				Tick_Time := RT.Clock;
				Next_Tick := Tick_Time + RT.Milliseconds(dt);
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
