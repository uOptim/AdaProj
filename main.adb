with Path;
with Robot;

with Ada.Text_IO;

procedure Main is
	use Path;
	package IO renames Ada.Text_IO;

	P: Path.Object;
	Rbt1: Robot.Object;
	Pos1: Robot.Position;
begin
	P := P & Path.Point'(100.0, 100.0);
	P := P & Path.Point'(200.0, 100.0);
	P := P & Path.Point'(300.0, 300.0);
	P := P & Path.Point'(0.0, 0.0);
	Rbt1.Follow(P);

	for i in 1..100 loop
		Rbt1.Get_Pos(Pos1);
		IO.Put_Line(Integer'Image(Pos1.X) & ":" & Integer'Image(Pos1.Y));
		delay 0.1;
	end loop;

	Rbt1.Shutdown;
end;
