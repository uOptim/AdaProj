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
	type Place_Type is (R, I, O);

	type Place is record
		Kind:  Place_Type;
		Taken: Boolean;
		X, Y:  Integer;
	end record;

	type Places is array(Place_ID) of Place;

	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;

	-- places
	In_Places, Out_Places, Ring_Places: Places;

	procedure Init;
	procedure Clear;
	procedure Destroy;

	procedure Draw_Site(In_Places, Out_Places, Ring_Places: Places);
	procedure Draw_Robot(P: Position; Color: Color_Type := Blue);

end;
