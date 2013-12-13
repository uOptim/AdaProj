package body Agency is

	procedure Get_To_Work is
	begin
		for Rbt of Robot_Collection loop
			Rbt.Go(Work_Site.In_Place'First+0, Work_Site.Out_Place'First+2);
		end loop;
	end;

	procedure Killall is
	begin
		for Rbt of Robot_Collection loop
			Rbt.Shutdown;
		end loop;
	end;
end;
