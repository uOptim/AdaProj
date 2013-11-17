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
				Draw_Site;
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

	procedure Draw_Site is
		P_Prev: Place(Kind => R);
	begin
		for P of IP loop
			Draw_Circle(P.X, P.Y, 5, Hue => Green, Filled => Fill);
		end loop;
		for P of OP loop
			Draw_Circle(P.X, P.Y, 5, Hue => Red, Filled => Fill);
		end loop;
		for P of RP loop
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
		for K in Place_ID'First..Place_ID'Last loop
			X := X_Max/2 + Integer( -- translate to center
				Radius*Cos(Float(K)*Radians_Cycle/Float(NPlaces), Radians_Cycle)
			);
			Y := Y_Max/2 + Integer( -- translate to center
				Radius*Sin(Float(K)*Radians_Cycle/Float(NPlaces), Radians_Cycle)
			);
			if X > X_Max/2 then
				IP(K) := Place'(Kind => I, Taken => False, X => X+20, Y => Y-10);
				OP(K) := Place'(Kind => O, Taken => False, X => X+20, Y => Y+10);
			else
				IP(K) := Place'(Kind => I, Taken => False, X => X-20, Y => Y-10);
				OP(K) := Place'(Kind => O, Taken => False, X => X-20, Y => Y+10);
			end if;
			RP(K) := Place'(Kind => R, Taken => False, X => X,    Y => Y);
		end loop;
		Center := Place'(Kind => C, Taken => False, X => X_Max/2, Y => Y_Max/2);
	end;
end;
