package Path is
	type Object is private;

	type Point is record
		X, Y: Float := 0.0;
	end record;

	type Points is array (Natural range <>) of Point;

	subtype Parameter is Float range 0.0..1.0;

	--
	Null_Path: constant Object;

	--
	function Value         (From: Points)    return Object;
	function Segment_Count (Path: in Object) return Natural;
	function Segment_Length(Path: in Object; Segment: in Positive)
		return Float;
	function "&"(Left: in Object; Right: in Object) return Object;
	function "&"(Left: in Object; Right: in Point ) return Object;
	function "&"(Left: in Point ; Right: in Object) return Object;

	procedure Add(Path: in out Object; P: in Point);

	function X(Path: in Object; Segment: in Positive; K: Parameter)
		return Float;
	function Y(Path: in Object; Segment: in Positive; K: Parameter)
		return Float;

	procedure Print(P: Object);

private
	subtype Count is Natural range 0..50;

	type Object(Size: Count := 0) is record
		Values: Points(1..Size);
	end record;

	Null_Path: constant Object := Object'(
		Size => 0,
		Values => (others => Point'(0.0, 0.0))
	);
end Path;
