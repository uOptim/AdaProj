with Path;
with Site;
with Site.Places_Path;

private generic
package Robot.Trajectory is

	type Object is tagged private;

	function X      (T: Object) return Float;
	function Y      (T: Object) return Float;
	function Route  (T: Object) return Path.Object;
	function Is_Done(T: Object) return Boolean;

	procedure Next (T: in out Object; dt: Float);
	procedure Open (
		T: in out Object;
		From: Work_Site.In_Place; To: Work_Site.Out_Place;
		Speed: Float := 100.0
	);
	procedure Close(T: in out Object);

private
	package Path_Maker is new Work_Site.Places_Path;

	procedure Reset(T: in out Object);

	type Object is tagged record
		K:       Float       := 0.0;
		Done:    Boolean     := True;
		Speed:   Float       := 5.0;
		Segment: Positive    := 1;
		Route:   Path.Object := Path.Null_Path;
		PM:      Path_Maker.Object;
	end record;
end;
