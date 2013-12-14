with Site;
with Robot;
with Mailbox;

with Ada.Numerics.Discrete_Random;

generic
	with package Work_Site   is new Site   (<>);
	with package Bot_Mailbox is new Mailbox(Message_Type => Work_Site.Bot_ID);

package Agency is

	task Mission_Listener is
		entry Start;
		entry Quit;
	end Mission_Listener;

private
	package Rand_In  is new Ada.Numerics.Discrete_Random(Work_Site.In_Place);
	package Rand_Out is new Ada.Numerics.Discrete_Random(Work_Site.Out_Place);

	Gen_In:  Rand_In.Generator;
	Gen_Out: Rand_Out.Generator;

	package Robot_Type is new Robot(
		Work_Site   => Work_Site,
		Mailbox_Pkg => Bot_Mailbox
	);

end Agency;
