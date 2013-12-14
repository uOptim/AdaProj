with Site;
with Robot;
with Mailbox;

with Ada.Numerics.Discrete_Random;

generic
	with package Work_Site   is new Site   (<>);
	with package Bot_Mailbox is new Mailbox(Message_Type => Work_Site.Bot_ID);

package Agency is

	procedure Get_To_Work;
	procedure Killall;

private
	package Rand_In  is new Ada.Numerics.Discrete_Random(Work_Site.In_Place);
	package Rand_Out is new Ada.Numerics.Discrete_Random(Work_Site.Out_Place);

	Gen_In:  Rand_In.Generator;
	Gen_Out: Rand_Out.Generator;

	package Robot_Type is new Robot(
		Work_Site   => Work_Site,
		Mailbox_Pkg => Bot_Mailbox
	);

	Done_Msg_Box: aliased Bot_Mailbox.Object(
		Size => Work_Site.Bot_ID'Last
	);

	type Robot_Array is array(Work_Site.Bot_ID'Range)
		of Robot_Type.Object(MBox => Done_Msg_Box'Access);

	Robot_Collection: Robot_Array;

end Agency;
