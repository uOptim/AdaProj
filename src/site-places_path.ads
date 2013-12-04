with Path;

generic
package Site.Places_Path is

	type Object is private;

	function Open    (From, To: Place_ID) return Object;
	function Get_Path(PP: Object        ) return Path.Object;
	function At_End  (PP: Object        ) return Boolean;

	function Robot_Intersects(P: Place_ID; R: Bot_ID) return Boolean;

private
	Place_Size: constant Float := 20.0;

	type Object is record
		P:  Path.Object;
		It: Positive := 1;
	end record;

end;
