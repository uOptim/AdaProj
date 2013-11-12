with Robot;
with Adagraph;

package Site is
	use Adagraph;

	type Position is record
		X, Y: Integer;
	end record;

	task Traffic is
		entry Stop;
		entry Start(NP: Positive; N: Positive; Tick_Len: Integer := 10);
		entry Update_Position(ID: Positive; P: Position);
	end;

	Invalid_ID: exception;

private
	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;

	procedure Init;
	procedure Clear;
	procedure Destroy;

	procedure Draw_Site(NP: Positive);
	procedure Draw_Robot(P: Position; Color: Color_Type := Blue);

end;
