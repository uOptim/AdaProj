with Site;
with Path;

generic
	with package Work_Site is new Site (<>);

package Robot is

	task type Object is
		entry Shutdown;
		entry Go(From: Work_Site.In_Place; To: Work_Site.Out_Place);
	end;

private
	dt: Float := 0.01; -- in seconds

	protected ID_Distributor is 
		procedure Get_ID(Rbt_ID: out Work_Site.Bot_ID);
	private
		-- We need a 0 to make our life easier in Get_ID()
		ID: Integer range 0 .. Work_Site.Bot_ID'Last := 0;
	end ID_Distributor;

end Robot;
