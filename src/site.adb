with Robot;
with Adagraph;

with Ada.Real_Time;
with Ada.Numerics.Elementary_Functions;
use  Ada.Numerics.Elementary_Functions;


package body Site is
	package RT renames Ada.Real_Time;

	task body Traffic is
		use type Ada.Real_Time.Time;
		use type Ada.Real_Time.Time_Span;

		type RobotPositions is array(Bot_ID) of Position;

		Tick_Time, Next_Tick: RT.Time;
		Positions: RobotPositions := (others => Position'(0, 0));
	begin
		-- wait for start signal
		accept Start;

		-- Clock
		Tick_Time := RT.Clock;
		Next_Tick := Tick_Time + RT.Milliseconds(Tick_Len);

		-- 'endless' update loop
		loop
			select
				accept Stop;
				exit;
			or
				accept Update_Position(ID: Bot_ID; P: Position) do
					Positions(ID) := P;
				end;
			or
				delay until Next_Tick;
				Clear;
				Draw_Site(In_Places, Out_Places, Ring_Places);
				for P of Positions loop
					Draw_Robot(P);
				end loop;
				Tick_Time := RT.Clock;
				Next_Tick := Tick_Time + RT.Milliseconds(Tick_Len);
			end select;
		end loop;

		Destroy;
	end;


	-- private functions and procedures.

	procedure Draw_Site(In_Places, Out_Places, Ring_Places: Places) is
	begin
		for P of In_Places loop
			Draw_Circle(P.X, P.Y, 5, Hue => Green, Filled => Fill);
		end loop;
		for P of Out_Places loop
			Draw_Circle(P.X, P.Y, 5, Hue => Red, Filled => Fill);
		end loop;
		for P of Ring_Places loop
			Draw_Circle(P.X, P.Y, 5, Hue => White, Filled => Fill);
		end loop;
	end;

	procedure Draw_Robot(P: Position; Color: Color_Type := Blue) is
	begin
		Draw_Circle(P.X, P.Y, 10, Hue => Color, Filled => Fill);
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

begin
	-- init window
	Init;

	-- init places
	declare
		X, Y: Integer;
		Radius: constant Float := 100.0;
		Radians_Cycle: constant Float := 2.0 * Ada.Numerics.Pi;
	begin
		for K in 1..NPlaces loop
			X := X_Max/2 + Integer( -- translate to center
				Radius*Cos(Float(K)*Radians_Cycle/Float(NPlaces), Radians_Cycle)
			);
			Y := Y_Max/2 + Integer( -- translate to center
				Radius*Sin(Float(K)*Radians_Cycle/Float(NPlaces), Radians_Cycle)
			);
			In_Places(K)   := Place'(I, False, X+20, Y);
			Out_Places(K)  := Place'(O, False, X-20, Y);
			Ring_Places(K) := Place'(R, False, X, Y);
		end loop;
	end;
end;
