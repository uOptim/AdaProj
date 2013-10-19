with Path;
with Adagraph;

package Robot is
	use Adagraph;

	task type Object(Color: Color_type := Light_Green) is
		entry Follow(P: in Path.Object);
		entry Shutdown;
	end;

private
	dK: Float    := 0.1;
	dt: Duration := 0.05;

	procedure Follow_Path(P: Path.Object);

end Robot;
