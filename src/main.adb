with Site;
with Agency;
with MailBox;
with Site.Places_Path;

with Ada.Text_IO;

procedure Main is
	package IO renames Ada.Text_IO;

	package HexSite     is new Site(NPlaces => 6, NRobots => 2);
	package Bot_Mailbox is new MailBox(Message_Type => HexSite.Bot_ID);
	package HexAgency   is new Agency(
		Work_Site   => HexSite,
		Bot_Mailbox => Bot_Mailbox
	);

begin
	HexSite.Traffic.Start;
	HexAgency.Get_To_Work;

	delay 5.0;

	HexAgency.Killall;
	HexSite.Traffic.Stop;
end;
