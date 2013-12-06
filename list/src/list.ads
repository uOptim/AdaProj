with Ada.Unchecked_Deallocation;

generic
	type Class is private;

package List is
	type Object is private;

	procedure Pop_Front (S: in out Object);
	procedure Pop_Back  (S: in out Object);
	procedure Push_Front(S: in out Object; A: in Class);
	procedure Push_Back (S: in out Object; A: in Class);
	procedure Clear     (S: in out Object);
	function  Size      (S: in     Object) return Natural;
	function  First     (S: in     Object) return Class;
	function  Last      (S: in     Object) return Class;
	function  Is_Empty  (S: in     Object) return Boolean;

private
	type Cell;
	type Cell_Ref is access Cell;

	type Cell is limited record
		Value: Class;
		Next:  Cell_Ref;
		Prev:  Cell_Ref;
	end record;

	type Object is record
		Size: Natural  := 0;
		Head: Cell_Ref := null;
		Tail: Cell_Ref := null;
	end record;

	procedure Free is new Ada.Unchecked_Deallocation(
		Object => Cell,
		Name => Cell_Ref
	);
end List;
