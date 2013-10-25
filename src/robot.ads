with Path;

package Robot is

	type Position is record
		X, Y: Integer;
	end record;

	task type Object is
		entry Follow(PP: in Path.Object);
		entry Get_Pos(PP: out Position);
		entry Shutdown;
	end;

private
	dt: Integer  := 100; -- in milliseconds
	dK: Float    := 0.1;

end Robot;
