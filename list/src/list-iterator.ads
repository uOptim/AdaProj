generic
package List.Iterator is

	type It is private;

	procedure Init_Front(I: in out It; L: Object);
	procedure Init_Back (I: in out It; L: Object);

	function "+"(Left: It; Right: Natural) return It;
	function "-"(Left: It; Right: Natural) return It;
	function Get(I: It) return Class;

	function Has_Next(I: It) return Boolean;
	function Has_Prev(I: It) return Boolean;

	Out_Of_Bounds: exception;

private
	type It is record
		C_Ref: Cell_Ref := null;
	end record;
end;
