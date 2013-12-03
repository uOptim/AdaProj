with Path;

generic
package Site.Places_Path is

	type Object is private;

	function Open    (From, To: Place_ID) return Object;
	function Get_Path(PP: Object        ) return Path.Object;
	function At_End  (PP: Object        ) return Boolean;

private

	type Object is record
		P:  Path.Object;
		It: Positive := 1;
	end record;

end;
