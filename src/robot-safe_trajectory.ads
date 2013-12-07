with Site.Places_Path;
with Generic_Resource_Pool;

with Robot;
with Robot.Trajectory;

private generic
package Robot.Safe_Trajectory is
	
	package Traj is new Robot.Trajectory;
	type Object is new Traj.Object with private;

	overriding procedure Next(T: in out Object; dt: Float);
	overriding procedure Open(
		T: in out Object;
		From: Work_Site.In_Place; To: Work_Site.Out_Place;
		Speed: Float := 100.0
	);
	overriding procedure Close(T: in out Object);

private
	package Resources is new Generic_Resource_Pool(
		Resource_ID => Work_Site.Place_Name
	);
	
	type Object is new Traj.Object with record
		Freed: Natural := 0;
	end record;
end;
