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
	P1 := P1 & Path.Point'(100.0, 100.0);
	P1 := P1 & Path.Point'(200.0, 100.0);
	P1 := P1 & Path.Point'(300.0, 500.0);
	P1 := P1 & Path.Point'(100.0, 100.0);
	P2 := P2 & Path.Point'(100.0, 400.0);
	P2 := P2 & Path.Point'(200.0, 100.0);
	P2 := P2 & Path.Point'(500.0, 500.0);
	P2 := P2 & Path.Point'(100.0, 100.0);

	HexSite.Traffic.Start;

	Rbt1.Follow(P1);
	Rbt2.Follow(P2);

	delay 10.0;

	HexSite.Traffic.Stop;

	Rbt1.Shutdown;
	Rbt2.Shutdown;
end;
