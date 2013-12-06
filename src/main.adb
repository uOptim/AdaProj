with Robot;
with Path;
with Site;
with Site.Places_Path;
--with Generic_Resource_Pool;

with Ada.Text_IO;

procedure Main is
	use Path;
	package IO renames Ada.Text_IO;

	package HexSite is new Site(NPlaces => 6, NRobots => 4);
	package HexBot  is new Robot(Work_Site => HexSite);

	P1, P2, P3, P4        : Path.Object;
	Rbt1, Rbt2, Rbt3, Rbt4: HexBot.Object;
begin
	HexSite.Traffic.Start;

	Rbt1.Go(HexSite.In_Place'First+1, HexSite.Out_Place'First+5);
	Rbt2.Go(HexSite.In_Place'First+2, HexSite.Out_Place'First+1);
	Rbt3.Go(HexSite.In_Place'First+5, HexSite.Out_Place'First+0);
	Rbt4.Go(HexSite.In_Place'First+0, HexSite.Out_Place'First+3);

	delay 5.0;

	Rbt1.Shutdown;
	Rbt2.Shutdown;
	Rbt3.Shutdown;
	Rbt4.Shutdown;

	HexSite.Traffic.Stop;
end;
