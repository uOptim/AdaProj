with Robot;
with Adagraph;

package body Render is

	procedure Draw_Map is
	begin
		null;
	end;

	procedure Draw_Robot(P: Robot.Position) is
	begin
		Adagraph.Draw_Circle(P.X, P.Y, 10);
	end;

	procedure Clear_Window is
	begin
		Adagraph.Clear_Window;
	end;

	procedure Init_Window is
	begin
		Adagraph.Create_Sized_Graph_Window(
			800, 600, X_Max, Y_Max, X_Char, Y_Char
			);
		Clear_Window;
		Adagraph.Set_Window_Title("Robots");
	end;

	procedure Destroy_Window is
	begin
		Adagraph.Destroy_Graph_Window;
	end;
end;
