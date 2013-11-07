with Path;

private package Robot.Trajectory is

	type Object is tagged private;

	function X     (T: Object) return Float;
	function Y     (T: Object) return Float;
	function Route (T: Object) return Path.Object;
	function At_End(T: Object) return Boolean;

	procedure Next (T: in out Object; dt: Float);
	procedure Open (T: in out Object; P: Path.Object; Speed: Float);
	procedure Close(T: in out Object);

private
	procedure Reset(T: in out Object);

	type Object is tagged record
		K:       Float       := 0.0;
		Done:    Boolean     := True;
		Speed:   Float       := 5.0;
		Segment: Positive    := 1;
		Route:   Path.Object := Path.Null_Path;
	end record;
end;
