with Path;
with Render;

package Robot is

	task type Object is
		entry Follow(PP: in Path.Object);
		entry Shutdown;
	end;

	Illegal_Path: exception;

private
	dt: Float := 0.100; -- in seconds

end Robot;
