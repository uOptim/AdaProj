with Site;
with Path;
with Robot;

with Ada.Text_IO;

procedure Main is
	use Path;
	package IO renames Ada.Text_IO;

	P1, P2    : Path.Object;
	Rbt1, Rbt2: Robot.Object;
begin
	P1 := P1 & Path.Point'(100.0, 100.0);
	P1 := P1 & Path.Point'(200.0, 100.0);
	P1 := P1 & Path.Point'(300.0, 500.0);
	P1 := P1 & Path.Point'(100.0, 100.0);
	P2 := P2 & Path.Point'(100.0, 400.0);
	P2 := P2 & Path.Point'(200.0, 100.0);
	P2 := P2 & Path.Point'(500.0, 500.0);
	P2 := P2 & Path.Point'(100.0, 100.0);

	Site.Traffic.Start(2, 10);

	Rbt1.Follow(P1);
	Rbt1.Follow(P2);

	delay 10.0;

	Site.Traffic.Stop;

	Rbt1.Shutdown;
	Rbt2.Shutdown;
end;
