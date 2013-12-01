with Site;
with Path;
with Robot;
with Generic_Resource_Pool;

with Ada.Text_IO;

procedure Main is
	use Path;
	package IO renames Ada.Text_IO;

	package HexSite is new Site(NPlaces => 6, NRobots => 4);
	package HexBot  is new Robot(Work_Site => HexSite);
	package Pool    is new Generic_Resource_Pool(Size => 6);

	P1, P2, P3, P4        : Path.Object;
	Rbt1, Rbt2, Rbt3, Rbt4: HexBot.Object;
begin
	P1 := HexSite.Make_Path(5, 1);
	P2 := HexSite.Make_Path(3, 6);
	P3 := HexSite.Make_Path(5, 2);
	P4 := HexSite.Make_Path(4, 6);

	HexSite.Traffic.Start;

	Rbt1.Follow(P1);
	Rbt2.Follow(P2);
	Rbt3.Follow(P3);
	Rbt4.Follow(P4);

	delay 5.0;

	HexSite.Traffic.Stop;

	Rbt1.Shutdown;
	Rbt2.Shutdown;
	Rbt3.Shutdown;
	Rbt4.Shutdown;
end;
