with Robot;
with Path;
with Site;
with Site.Places_Path;
--with Generic_Resource_Pool;

with Ada.Text_IO;

procedure Main is
	use Path;
	package IO renames Ada.Text_IO;

	package HexSite    is new Site(NPlaces => 6, NRobots => 4);
	package HexBot     is new Robot(Work_Site => HexSite);
	package Path_Maker is new HexSite.Places_Path;

	P1, P2, P3, P4        : Path.Object;
	Rbt1, Rbt2, Rbt3, Rbt4: HexBot.Object;
begin
	HexSite.Traffic.Start;

	P1 := Path_Maker.Get_Path(
		Path_Maker.Open(
			HexSite.Ring_Place'First-1+5,
			HexSite.Ring_Place'First-1+1
		)
	);
	P2 := Path_Maker.Get_Path(
		Path_Maker.Open(
			HexSite.Ring_Place'First-1+3,
			HexSite.Ring_Place'First-1+6
		)
	);
	P3 := Path_Maker.Get_Path(
		Path_Maker.Open(
			HexSite.Ring_Place'First-1+5,
			HexSite.Ring_Place'First-1+2
		)
	);
	P4 := Path_Maker.Get_Path(
		Path_Maker.Open(
			HexSite.Ring_Place'First-1+4,
			HexSite.Ring_Place'First-1+6
		)
	);

	Rbt1.Follow(P1);
	Rbt2.Follow(P2);
	Rbt3.Follow(P3);
	Rbt4.Follow(P4);

	delay 5.0;

	Rbt1.Shutdown;
	Rbt2.Shutdown;
	Rbt3.Shutdown;
	Rbt4.Shutdown;

	HexSite.Traffic.Stop;
end;
