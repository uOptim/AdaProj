with Site;
with Site.Places_Path;
with Agency;

with Ada.Text_IO;

procedure Main is
	package IO renames Ada.Text_IO;

	package HexSite is new Site(NPlaces => 6, NRobots => 4);
	package HexAgency is new Agency(Work_Site => HexSite);

begin
	HexSite.Traffic.Start;
	HexAgency.Get_To_Work;

	delay 5.0;

	HexAgency.Killall;
	HexSite.Traffic.Stop;
end;
