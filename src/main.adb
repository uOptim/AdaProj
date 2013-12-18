with Site;
with Agency;
with MailBox;
with Site.Places_Path;

with Adagraph;
with Ada.Text_IO;

procedure Main is
	package IO renames Ada.Text_IO;

	package HexSite     is new Site(NPlaces => 8, NRobots => 12);
	package Bot_Mailbox is new MailBox(Message_Type => HexSite.Bot_ID);
	package HexAgency   is new Agency(
		Work_Site   => HexSite,
		Bot_Mailbox => Bot_Mailbox
	);

	K: Character;
begin
	HexSite.Traffic.Start;
	HexAgency.Mission_Listener.Start;

	--delay 20.0;
	K := Adagraph.Get_Key;

	HexAgency.Mission_Listener.Quit;
	HexSite.Traffic.Stop;
end;
