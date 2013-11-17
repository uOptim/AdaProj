with Adagraph;

generic
	NPlaces:  Positive := 6;
	NRobots:  Positive := 1;
	Tick_Len: Positive := 50; -- in ms
package Site is
	use Adagraph;

	subtype Place_ID is Positive range 1..NPlaces;
	subtype Bot_ID is Positive range 1..NRobots;

	type Position is record
		X, Y: Integer;
	end record;

	task Traffic is
		entry Stop;
		entry Start;
		entry Update_Position(ID: Bot_ID; P: Position);
	end;

private
	type Place_Type is (C, R, I, O);

	type Place(Kind: Place_Type) is record
		Taken: Boolean;
		X, Y:  Integer;
	end record;

	type In_Places   is array(Place_ID) of Place(Kind => I);
	type Out_Places  is array(Place_ID) of Place(Kind => O);
	type Ring_Places is array(Place_ID) of Place(Kind => R);

	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;

	-- places
	Center: Place(Kind => C);
	IP: In_Places;
	OP: Out_Places;
	RP: Ring_Places;

	procedure Init;
	procedure Clear;
	procedure Destroy;

	procedure Draw_Site;
	procedure Draw_Robot(P: Position; Color: Color_Type := Blue);
end;
