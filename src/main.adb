with Site;
with Agency;
with MailBox;
with Site.Places_Path;

with Ada.Text_IO;

procedure Main is
	package IO renames Ada.Text_IO;

	package HexSite     is new Site(NPlaces => 6, NRobots => 3);
	package Bot_Mailbox is new MailBox(Message_Type => HexSite.Bot_ID);
	package HexAgency   is new Agency(
		Work_Site   => HexSite,
		Bot_Mailbox => Bot_Mailbox
	);

begin
	HexSite.Traffic.Start;
	HexAgency.Mission_Listener.Start;

	delay 10.0;

	HexAgency.Mission_Listener.Quit;
	HexSite.Traffic.Stop;
end;
