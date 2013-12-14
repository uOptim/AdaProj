with Robot;

with Adagraph;

with Ada.Real_Time;
with Ada.Numerics.Elementary_Functions;


package body Site is
	use  Ada.Numerics.Elementary_Functions;

	package RT renames Ada.Real_Time;

	--
	-- Site area
	--
	task body Traffic is
		use type Ada.Real_Time.Time;
		use type Ada.Real_Time.Time_Span;

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
				Adagraph.Set_Immediate_Rendering(False);
				Draw_Site;
				for P of Positions loop
					Draw_Robot(P);
				end loop;
				Adagraph.Set_Immediate_Rendering(True);
				Tick_Time := RT.Clock;
				Next_Tick := Tick_Time + RT.Milliseconds(Tick_Len);
			end select;
		end loop;

		Destroy;
	end;

	function Next(R: Ring_Place) return Ring_Place is
		Center: Ring_Place := Ring_Place'Last;
	begin
		if R = Center then
			raise Illegal_Place;
		elsif R = (Ring_Place'Last-1) then
			return Ring_Place'First;
		else
			return Ring_Place'Succ(R);
		end if;
	end;

	function Prev(R: Ring_Place) return Ring_Place is
		Center: Ring_Place := Ring_Place'Last;
	begin
		if R = Center then
			raise Illegal_Place; -- there is no 'Prev' for the center Place
		elsif R = Ring_Place'First then
			return Ring_Place'Last-1;
		else
			return Ring_Place'Pred(R);
		end if;
	end;

	function Opposite(R: Ring_Place) return Ring_Place is
		Center: Ring_Place := Ring_Place'Last;
		Tmp:    Integer    := R - Ring_Place'First + NPlaces/2;
	begin
		if R = Center then
			raise Illegal_Place;
		end if;
		if (Tmp >= NPlaces) then
			Tmp := Tmp - NPlaces;
		end if;
		return Ring_Place(Ring_Place'First + Tmp);
	end;

	function Way_In(R: Ring_Place) return In_Place is
		(R+In_Place'First-Ring_Place'First);

	function Way_Out(R: Ring_Place) return Out_Place is
		(R+Out_Place'First-Ring_Place'First);

	-- private functions and procedures.

	procedure Draw_Site is
		P_Prev, Center: Place;
	begin
		for P of Places(In_Place'Range) loop
			Draw_Circle(P.X, P.Y, 5, Hue => Green, Filled => Fill);
		end loop;
		for P of Places(Out_Place'Range) loop
			Draw_Circle(P.X, P.Y, 5, Hue => Red, Filled => Fill);
		end loop;
		for P of Places(Ring_Place'Range) loop
			Draw_Circle(P.X, P.Y, 5, Hue => White, Filled => Fill);
		end loop;
		-- lines
		Center := Places(Ring_Place'Last);
		P_Prev := Places(Ring_Place'Last-1);
		for P of Places(Ring_Place'First..(Ring_Place'Last-1)) loop
			-- lines to the center
			Draw_Line(P.X, P.Y, Center.X, Center.Y, Hue => White);
			-- line to the previous point
			Draw_Line(P.X, P.Y, P_Prev.X, P_Prev.Y, Hue => White);
			P_Prev := P; -- remember last drawn place
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


	--
	-- Parking stuff
	--
	protected body Parking is

		function Is_Empty return Boolean is
			(Robot_List.Size(Frees) > 0);

		procedure Park(ID: Bot_ID) is
		begin
			if (Frees_Mask(ID)) then
				raise Illegal_Park;
			end if;
			Robot_List.Push_Back(Frees, ID);
			Frees_Mask(ID) := True;
		end;

		entry Take(ID: in out Bot_ID) when not Is_Empty is
		begin
			ID := Robot_List.First(Frees);
			Robot_List.Pop_Front(Frees);
			Frees_Mask(ID) := False;
		end;

	end Parking;

begin
	-- init window
	Init;

	-- init places
	declare
		X, Y: Integer;
		Radius: constant Float := 200.0;
		Radians_Cycle: constant Float := 2.0 * Ada.Numerics.Pi;
	begin
		-- center
		Places(Ring_Place'Last) := Place'(X => X_Max/2, Y => Y_Max/2);

		-- ring without the center
		for K in 0..(NPlaces-1) loop
			X := X_Max/2 + Integer( -- translate to center of screen
				Radius * Cos(
					Float(K)*Radians_Cycle/Float(NPlaces),
					Radians_Cycle
				)
			);
			Y := Y_Max/2 + Integer( -- translate to center of screen
				Radius * Sin(
					Float(K)*Radians_Cycle/Float(NPlaces),
					Radians_Cycle
				)
			);

			Places(Ring_Place(K+Ring_Place'First)) := Place'(X => X, Y => Y);

			if X > X_Max/2 then
				Places(In_Place (K+In_Place'First )) := Place'(X => X+20, Y => Y-10);
				Places(Out_Place(K+Out_Place'First)) := Place'(X => X+20, Y => Y+10);
			else
				Places(In_Place (K+In_Place'First )) := Place'(X => X-20, Y => Y-10);
				Places(Out_Place(K+Out_Place'First)) := Place'(X => X-20, Y => Y+10);
			end if;
		end loop;
	end;
end;
