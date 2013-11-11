with Path;

package Robot is

	task type Object is
		entry Follow(PP: in Path.Object);
		entry Shutdown;
	end;

	Illegal_Path: exception;

private
	dt: Float := 0.100; -- in seconds
	ID: Positive := 1;

	function Get_ID return Positive;

end Robot;
