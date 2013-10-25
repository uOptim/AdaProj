with Robot;
with Adagraph;

package Render is
	use Adagraph;

	procedure Init_Window;
	procedure Clear_Window;
	procedure Destroy_Window;

	procedure Draw_Map;
	procedure Draw_Robot(P: Robot.Position; Color: Color_Type := Blue);

private
	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;
end;
