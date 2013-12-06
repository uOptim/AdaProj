package body List.Iterator is

	procedure Init_Front(I: in out It; L: Object) is
	begin
		I := It'(C_Ref => L.Head);
	end;

	procedure Init_Back(I: in out It; L: Object) is
	begin
		I := It'(C_Ref => L.Tail);
	end;


	function "+"(Left: It; Right: Natural) return It is
		Cr: Cell_Ref := Left.C_Ref;
	begin
		for I in 1..Right loop
			if Cr.all.Next = null then
				raise Out_Of_Bounds;
			end if;
			Cr := Cr.all.Next;
		end loop;
		return It'(C_Ref => Cr);
	end;


	function "-"(Left: It; Right: Natural) return It is
		Cr: Cell_Ref := Left.C_Ref;
	begin
		for I in 1..Right loop
			if Cr.all.Prev = null then
				raise Out_Of_Bounds;
			end if;
			Cr := Cr.all.Prev;
		end loop;
		return It'(C_Ref => Cr);
	end;


	function Get(I: It) return Class is
		(I.C_Ref.all.Value);

	function Has_Next(I: It) return Boolean is
		(I.C_Ref.all.Next /= null);

	function Has_Prev(I: It) return Boolean is
		(I.C_Ref.all.Prev /= null);
end;
