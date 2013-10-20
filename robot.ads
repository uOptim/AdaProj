with Path;
with Adagraph;

package Robot is
	use Adagraph;

	type Position is record
		X, Y: Integer;
	end record;

	task type Object(Color: Color_type := Light_Green) is
		entry Follow(PP: in Path.Object);
		entry Get_Pos(PP: out Position);
		entry Shutdown;
		entry Tick;
	end;

private
	dK: Float    := 0.1;
	dt: Duration := 0.05;

end Robot;
