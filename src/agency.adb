with Ada.Text_IO;

with Ada.Exceptions;
use Ada.Exceptions;


package body Agency is

	procedure Get_To_Work is
	begin
		for Rbt of Robot_Collection loop
			Rbt.Go(Rand_In.Random(Gen_In), Rand_Out.Random(Gen_Out));
		end loop;
	end;

	procedure Killall is
	begin
		for Rbt of Robot_Collection loop
			Rbt.Shutdown;
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
