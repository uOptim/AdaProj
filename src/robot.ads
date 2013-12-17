with Site;
with Mailbox;

generic
	with package Work_Site   is new Site (<>);
	with package Mailbox_Pkg is new Mailbox (Message_Type => Work_Site.Bot_ID);

package Robot is

	task type Object(MBox: access Mailbox_Pkg.Object) is
		entry Start(I: Work_Site.Bot_ID);
		entry Shutdown;
		entry Go(From: Work_Site.In_Place; To: Work_Site.Out_Place);
	end;

private
	dt: Float := 0.01; -- in seconds

end Robot;
