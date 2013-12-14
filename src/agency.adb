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
	end;

begin
	Rand_In.Reset(Gen_In);
	Rand_Out.Reset(Gen_Out);
end;
