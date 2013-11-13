with Site;
with Path;

generic
	with package Work_Site is new Site (<>);
package Robot is

	task type Object is
		entry Follow(PP: in Path.Object);
		entry Shutdown;
	end;

	Illegal_Path: exception;

private
	dt: Float := 0.100; -- in seconds

	-- We need a 0 to make our life easier in Get_ID()
	ID: Integer range 0 .. Work_Site.Bot_ID'Last := 0;

	function Get_ID return Work_Site.Bot_ID;

end Robot;
