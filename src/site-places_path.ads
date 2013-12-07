with Path;
with List;
with List.Iterator;
with Ada.Unchecked_Deallocation;

generic
package Site.Places_Path is

	type Object is tagged private;

	type Place_Name_Array is array (Positive range <>) of Place_Name;

	function  Open (From: In_Place; To: Out_Place) return Object;
	procedure Close(O: in out Object);

	function Size    (O: Object) return Natural;
	function Value   (O: Object) return Place_Name_Array;
	function Get_Path(O: Object) return Path.Object;
	function At_End  (O: Object) return Boolean;

	function Robot_Intersects(P: Place_Name; Pos: Site.Position) return Boolean;


private
	Place_Size: constant Float := 20.0;

	package Places_List     is new List(Class => Place_Name);
	package Places_Iterator is new Places_List.Iterator;

	type Object is tagged record
		It: Positive := 1;
		PP: Places_List.Object;
	end record;

	--procedure Free_PP is new Ada.Unchecked_Deallocation(
	--	Object => Places_List.Object,
	--	Name => Places_List_Ref
	--);
end;
