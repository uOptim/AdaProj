with Adagraph;

generic
	NPlaces:  Positive := 6;
	NRobots:  Positive := 1;
	Tick_Len: Positive := 50; -- in ms
package Site is
	use Adagraph;

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
	subtype Place_ID is Positive range 1..NPlaces;

	type Place is tagged record
		Taken: Boolean;
		X, Y:  Integer;
	end record;

	type Place_With_ID is new Place with record
		ID: Place_ID;
	end record;

	subtype In_Place   is Place_With_ID;
	subtype Out_Place  is Place_With_ID;
	subtype Ring_Place is Place_With_ID;

	type In_Places   is array(Place_ID) of In_Place;
	type Out_Places  is array(Place_ID) of Out_Place;
	type Ring_Places is array(Place_ID) of Ring_Place;

	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;

	-- places
	Center: Place;
	IP: In_Places;
	OP: Out_Places;
	RP: Ring_Places;

	procedure Init;
	procedure Clear;
	procedure Destroy;

	procedure Draw_Site;
	procedure Draw_Robot(P: Position; Color: Color_Type := Blue);
end;
