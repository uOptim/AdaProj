with Site;
with Robot;

generic
	Effectif: Positive := 4; -- 4 robots default
	with package Work_Site is new Site (<>);

package Agency is

	procedure Get_To_Work;
	procedure Killall;

private
	package Robot_Type is new Robot(Work_Site);

	type Robot_Array is array(1..Effectif) of Robot_Type.Object;

	Robot_Collection: Robot_Array;

end Agency;
