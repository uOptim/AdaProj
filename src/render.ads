with Adagraph;

package Render is
	use Adagraph;

	type Position is record
		X, Y: Integer;
	end record;


	task Traffic is -- dt in milliseconds
		entry Stop;
		entry Start(N: Positive; Tick_Len: Integer);
		entry Update_Position(ID: Positive; P: Position);
	end;

	Invalid_ID: exception;

private
	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;

	procedure Init_Window;
	procedure Clear_Window;
	procedure Destroy_Window;

	procedure Draw_Map;
	procedure Draw_Robot(P: Position; Color: Color_Type := Blue);


end;
