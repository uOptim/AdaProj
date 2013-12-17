with Ada.Text_IO;

with Ada.Exceptions;
use Ada.Exceptions;


package body Agency is

	task body Mission_Listener is
		ID: Work_Site.Bot_ID;

	begin
		accept Start;

		-- give a mission to all bots
		for ID in Robot_Collection'Range loop
			Robot_Collection(ID).Start(ID);
			Robot_Collection(ID).Go(Rand_In.Random(Gen_In), Rand_Out.Random(Gen_Out));
		end loop;

		-- listen signals and wait for free bots
		loop
			select
				accept Quit do
					-- Note: this MUST block the caller until all bots are shut
					-- down. Otherwise, the caller might kill the Work_Site
					-- before our robots have a chance to shutdown properly.
					for Rbt of Robot_Collection loop
						Rbt.Shutdown;
					end loop;
				end;
				exit;
			else
				if not Done_Msg_Box.Is_Empty then
					Done_Msg_Box.Get(ID);
					-- give a new mission
					Robot_Collection(ID).Go(
						Rand_In.Random(Gen_In), Rand_Out.Random(Gen_Out)
					);
				else
					delay 0.5;
				end if;
			end select;
		end loop;

	exception
		when Error: others =>
			Ada.Text_IO.Put("Mission_Listener raised: ");
			Ada.Text_IO.Put_Line(Exception_Information(Error));
	end;

begin
	Rand_In.Reset(Gen_In);
	Rand_Out.Reset(Gen_Out);
end;
