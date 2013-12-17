with Robot.Safe_Trajectory;

with Ada.Text_IO;
with Ada.Real_Time;

with Ada.Exceptions;
use Ada.Exceptions;


package body Robot is
	package IO renames Ada.Text_IO;
	package RT renames Ada.Real_Time;

	package Route is new Robot.Safe_Trajectory;

	use type Ada.Real_Time.Time, Ada.Real_Time.Time_Span;

	task body Object is
		T:  Route.Object;
		ID: Work_Site.Bot_ID;
		Tick_Time, Next_Tick: RT.Time;

		From_Tmp: Work_Site.In_Place;
		To_Tmp:   Work_Site.Out_Place;
	begin

		Tick_Time := RT.Clock;
		Next_Tick := Tick_Time + RT.Milliseconds(Integer(1000.0*dt));

		accept start(I: Work_Site.Bot_ID) do
			ID := I;
		end;
		IO.Put_Line("I am robot number" & Positive'Image(ID));

		loop
			select
				accept Go(From: Work_Site.In_Place; To: Work_Site.Out_Place) do
					-- save for later because we might block the caller when
					-- opening the path
					To_Tmp   := To;
					From_Tmp := From;
				end;
				if (not T.Is_Done) then
					T.Close;
					IO.Put_Line(
						"Robot" & Positive'Image(ID)
						& " got new task when previous one wasn't done!"
					);
				end if;
				IO.Put_Line("Robot" & Positive'Image(ID) & " got new task");
				T.Open(From_Tmp, To_Tmp);
				Work_Site.Robot_Positions.Set(
					ID, Work_Site.Position'(Integer(T.X), Integer(T.Y))
				);
			or
				when not T.Is_Done => delay until Next_Tick;
				Tick_Time := RT.Clock;
				Next_Tick := Tick_Time + RT.Milliseconds(Integer(1000.0*dt));
				T.Next(dt);
				Work_Site.Robot_Positions.Set(
					ID, Work_Site.Position'(Integer(T.X), Integer(T.Y))
				);
				if T.Is_Done then
					T.Close;
					IO.Put_Line("Robot" & Positive'Image(ID) & " completed task");
					MBox.Put(ID);
				end if;
			or
				when T.Is_Done => accept Shutdown;
				IO.Put_Line("Robot" & Positive'Image(ID) & " shuting down");
				if (not T.Is_Done) then
					T.Close;
				end if;
				exit;
			end select;
		end loop;

	exception
		when Error: others =>
			Ada.Text_IO.Put("Robot" & Work_Site.Bot_ID'Image(ID) & " raised: ");
			Ada.Text_IO.Put_Line(Exception_Information(Error));
	end;

end;
