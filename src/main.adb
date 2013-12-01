with Site;
with Path;
with Robot;

with Ada.Text_IO;

procedure Main is
	use Path;
	package IO renames Ada.Text_IO;

	package HexSite is new Site(NPlaces => 6, NRobots => 2);
	package HexBot  is new Robot(Work_Site => HexSite);

	P1, P2    : Path.Object;
	Rbt1, Rbt2: HexBot.Object;
begin
	P1 := HexSite.Make_Path(1, 3);
	P2 := HexSite.Make_Path(2, 5);

	Path.Print(P1);
	Path.Print(P2);

	HexSite.Traffic.Start;

	Rbt1.Follow(P1);
	Rbt2.Follow(P2);

	delay 5.0;

	HexSite.Traffic.Stop;

	Rbt1.Shutdown;
	Rbt2.Shutdown;
end;
