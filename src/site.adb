with Robot;
with Adagraph;

with Ada.Real_Time;
with Ada.Numerics.Elementary_Functions;
use  Ada.Numerics.Elementary_Functions;


package body Site is
	package RT renames Ada.Real_Time;

	task body Traffic is
		type RobotPositions is array(Positive range <>) of Position;

		dt:      Integer;
		NBots:   Positive;
		NPlaces: Positive;
	begin
		-- wait for start signal
		accept Start(NP: Positive; N: Positive; Tick_Len: Integer := 10) do
			dt      := Tick_Len;
			NBots   := N;
			NPlaces := NP;
		end;

		Init;

		declare
			use type Ada.Real_Time.Time, Ada.Real_Time.Time_Span;

			Positions: RobotPositions(1..NBots) := (others => Position'(0, 0));
			Tick_Time, Next_Tick: RT.Time;
		begin
			Tick_Time := RT.Clock;
			Next_Tick := Tick_Time + RT.Milliseconds(dt);

			-- 'endless' update loop
			loop
				select
					accept Stop;
					exit;
				or
					accept Update_Position(ID: Positive; P: Position) do
						if ID > NBots then raise Invalid_ID; end if;
						Positions(ID) := P;
					end;
				or
					delay until Next_Tick;
					Clear;
					Draw_Site(NPlaces);
					for P of Positions loop
						Draw_Robot(P);
					end loop;
					Tick_Time := RT.Clock;
					Next_Tick := Tick_Time + RT.Milliseconds(dt);
				end select;
			end loop;
		end;

		Destroy;
	end;


	-- private functions and procedures.

	procedure Draw_Site(NP: Positive) is
		Radius: constant Float := 100.0;
		Radians_Cycle : constant Float := 2.0 * Ada.Numerics.Pi;
	begin
		for K in 0 .. NP-1 loop
			Draw_Circle(
				X_Max/2+Integer(
					Radius*Cos(Float(K) * Radians_Cycle / Float(NP), Radians_Cycle)
				),
				Y_Max/2+Integer(
					Radius*Sin(Float(K) * Radians_Cycle / Float(NP), Radians_Cycle)
				),
				10,
				Hue => White
			);
		end loop;
	end;

	procedure Draw_Robot(P: Position; Color: Color_Type := Blue) is
	begin
		Draw_Circle(P.X, P.Y, 10, Hue => Color);
	end;

	procedure Clear is
	begin
		Clear_Window;
	end;

	procedure Init is
	begin
		Create_Sized_Graph_Window(800, 600, X_Max, Y_Max, X_Char, Y_Char);
		Set_Window_Title("Robots");
		Clear;
	end;

	procedure Destroy is
	begin
		Destroy_Graph_Window;
	end;
end;
