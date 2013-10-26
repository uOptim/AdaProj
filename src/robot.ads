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

	Illegal_Path: exception;

private
	dt: Float := 0.100; -- in seconds

end Robot;
