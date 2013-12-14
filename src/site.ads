with List;
with Adagraph;

generic
	NPlaces:  Positive := 6;
	NRobots:  Positive := 1;
	Tick_Len: Positive := 50; -- in ms

package Site is
	use Adagraph;

	--
	-- Site area
	--
	subtype Bot_ID     is Positive range 1..NRobots;
	subtype Place_Name is Positive range 1..(3*NPlaces+1);

	-- Ring_Place includes the center (last index)
	subtype In_Place   is Place_Name range (0*NPlaces+1)..(1*NPlaces);
	subtype Out_Place  is Place_Name range (1*NPlaces+1)..(2*NPlaces);
	subtype Ring_Place is Place_Name range (2*NPlaces+1)..(3*NPlaces+1);

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

	Illegal_Place: exception;


	--
	-- Parking stuff
	--
	package Robot_List is new List(Class => Bot_ID);

	type Free_Robots_Mask is array(Bot_ID'First..Bot_ID'Last) of Boolean;

	protected type Parking is
		procedure Park(ID: Bot_ID);
		entry Take(ID: in out Bot_ID);
		function Is_Empty return Boolean;
	private
		Frees: Robot_List.Object;
		Frees_Mask: Free_Robots_Mask := (others => False);
	end Parking;

	Illegal_Park: exception;

private
	-- adagraph init vars
	X_Max, Y_Max, X_Char, Y_Char: Integer;

	type Place is tagged record
		X, Y:  Integer;
	end record;

	type Places_Array is array(Place_Name) of Place;

	-- places
	Places: Places_Array;

	-- Position of our Robots
	type RobotPositions is array(Bot_ID) of Position;

	procedure Init;
	procedure Clear;
	procedure Destroy;

	procedure Draw_Site;
	procedure Draw_Robot(P: Position; Color: Color_Type := Blue);
end;
