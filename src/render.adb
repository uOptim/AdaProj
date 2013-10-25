with Robot;
with Adagraph;

package body Render is

	procedure Draw_Map is
	begin
		null;
	end;

	procedure Draw_Robot(P: Robot.Position; Color: Color_Type := Blue) is
	begin
		Draw_Circle(P.X, P.Y, 10, Hue => Color);
	end;

	procedure Clear_Window is
	begin
		Adagraph.Clear_Window;
	end;

	procedure Init_Window is
	begin
		Create_Sized_Graph_Window(
			800, 600, X_Max, Y_Max, X_Char, Y_Char
			);
		Render.Clear_Window;
		Set_Window_Title("Robots");
	end;

	procedure Destroy_Window is
	begin
		Destroy_Graph_Window;
	end;
end;
