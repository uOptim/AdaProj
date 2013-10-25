with Robot;
with Adagraph;

package Render is

	procedure Init_Window;
	procedure Clear_Window;
	procedure Destroy_Window;

	procedure Draw_Map;
	procedure Draw_Robot(P: Robot.Position);

private
	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;
end;
