with Adagraph;

generic
	NPlaces:  Positive := 6;
	NRobots:  Positive := 1;
	Tick_Len: Positive := 50; -- in ms
package Site is
	use Adagraph;

	type Place is tagged private;
	type Place_With_ID is private;

	subtype In_Place   is Place_With_ID;
	subtype Out_Place  is Place_With_ID;
	subtype Ring_Place is Place_With_ID;

	subtype Bot_ID   is Positive range 1..NRobots;
	subtype Place_ID is Positive range 1..NPlaces;

	type Position is record
		X, Y: Integer;
	end record;

	task Traffic is
		entry Stop;
		entry Start;
		entry Update_Position(ID: Bot_ID; P: Position);
	end;

	function Next    (R: Ring_Place) return Ring_Place;
	function Prev    (R: Ring_Place) return Ring_Place;
	function Way_In  (R: Ring_Place) return In_Place;
	function Way_Out (R: Ring_Place) return Out_Place;
	function Opposite(R: Ring_Place) return Ring_Place;

private

	type Place is tagged record
		Taken: Boolean;
		X, Y:  Integer;
	end record;

	type Place_With_ID is new Place with record
		ID: Place_ID;
	end record;

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
