with Site;
with Path;

generic
	with package Work_Site is new Site (<>);
package Robot is

	task type Object is
		entry Follow(PP: in Path.Object);
		entry Shutdown;
	end;

private
	dt: Float := 0.01; -- in seconds

	protected ID_Distributor is 
		procedure Get_ID(Bot_ID: out Work_Site.Bot_ID);
	private
		-- We need a 0 to make our life easier in Get_ID()
		ID: Integer range 0 .. Work_Site.Bot_ID'Last := 0;
	end ID_Distributor;

end Robot;
