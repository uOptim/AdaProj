with Adagraph;

generic
	NPlaces:  Positive := 6;
	NRobots:  Positive := 1;
	Tick_Len: Positive := 10; -- in ms
package Site is
	use Adagraph;

	type Position is record
		X, Y: Integer;
	end record;

	task Traffic is
		entry Stop;
		entry Start;
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
