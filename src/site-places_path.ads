with Path;
with List;
with List.Iterator;
with Ada.Unchecked_Deallocation;

generic
package Site.Places_Path is

	type Object is private;

	function  Open (From: In_Place; To: Out_Place) return Object;
	procedure Close(O: in out Object);

	function Get_Path(O: Object) return Path.Object;
	function At_End  (O: Object) return Boolean;

	function Robot_Intersects(P: Ring_Place; R: Bot_ID) return Boolean;

private
	Place_Size: constant Float := 20.0;

	package Places_List     is new List(Class => Place);
	package Places_Iterator is new Places_List.Iterator;

	type Places_List_Ref is access Places_List.Object;

	type Object is record
		It: Positive := 1;
		PP: Places_List.Object;
	end record;

	--procedure Free_PP is new Ada.Unchecked_Deallocation(
	--	Object => Places_List.Object,
	--	Name => Places_List_Ref
	--);
end;
