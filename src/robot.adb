with Site;
with Robot.Trajectory;

with Ada.Text_IO;
with Ada.Real_Time;


package body Robot is
	package IO renames Ada.Text_IO;
	package RT renames Ada.Real_Time;
	use type Ada.Real_Time.Time, Ada.Real_Time.Time_Span;

	task body Object is
		T: Robot.Trajectory.Object;
		Tick_Time, Next_Tick: RT.Time;
	begin
		Tick_Time := RT.Clock;
		Next_Tick := Tick_Time + RT.Milliseconds(Integer(1000.0*dt));
		loop
			select
				accept Follow(PP: in Path.Object) do
					T.Open(PP, 400.0);
				end;
			or
				when not T.Is_Done => delay until Next_Tick;
				Tick_Time := RT.Clock;
				Next_Tick := Tick_Time + RT.Milliseconds(Integer(1000.0*dt));

				T.Next(dt);
				Site.Traffic.Update_Position(
					ID, Site.Position'(Integer(T.X), Integer(T.Y))
				);
			or
				accept Shutdown do
					IO.Put_Line("Robot shuting down");
				end;
				exit;
			end select;
		end loop;
	end;

end;
