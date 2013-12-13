with Site;
with Robot;
with Mailbox;

generic
	with package Work_Site is new Site (<>);

package Agency is

	procedure Get_To_Work;
	procedure Killall;

private
	package Bot_Mailbox is new Mailbox(Message_Type => Work_Site.Bot_ID);
	package Robot_Type  is new Robot(
		Work_Site   => Work_Site,
		Mailbox_Pkg => Bot_Mailbox
	);

	Done_Msg_Box: aliased Bot_Mailbox.Object(Size => Work_Site.Bot_ID'Last);

	type Robot_Array is array(Work_Site.Bot_ID'Range)
		of Robot_Type.Object(MBox => Done_Msg_Box'Access);

	Robot_Collection: Robot_Array;

end Agency;
