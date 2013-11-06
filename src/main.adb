with Path;
with Robot;
with Render;

with Ada.Text_IO;

procedure Main is
	use Path;
	package IO renames Ada.Text_IO;

	P: Path.Object;
	Rbt1: Robot.Object;
begin
	P := P & Path.Point'(100.0, 100.0);
	P := P & Path.Point'(200.0, 100.0);
	P := P & Path.Point'(300.0, 500.0);
	P := P & Path.Point'(100.0, 100.0);
	P := P & Path.Point'(100.0, 400.0);
	P := P & Path.Point'(200.0, 100.0);
	P := P & Path.Point'(500.0, 500.0);
	P := P & Path.Point'(100.0, 100.0);
	Rbt1.Follow(P);

	Render.Traffic.Start(1, 10);

	delay 10.0;

	Render.Traffic.Stop;

	Rbt1.Shutdown;
end;
