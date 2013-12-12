with Path;

package body Agency is

	procedure Get_To_Work is
	begin
		Robot_Collection(1).Go(Work_Site.In_Place'First+1, Work_Site.Out_Place'First+5);
		Robot_Collection(2).Go(Work_Site.In_Place'First+1, Work_Site.Out_Place'First+4);
		Robot_Collection(3).Go(Work_Site.In_Place'First+1, Work_Site.Out_Place'First+3);
		Robot_Collection(4).Go(Work_Site.In_Place'First+1, Work_Site.Out_Place'First+2);
	end;

	procedure Killall is
	begin
		Robot_Collection(1).Shutdown;
		Robot_Collection(2).Shutdown;
		Robot_Collection(3).Shutdown;
		Robot_Collection(4).Shutdown;
	end;
end;
