package body List is

	procedure Pop_Front(S: in out Object) is
		C: Cell_Ref := S.Head;
	begin
		if C /= null then
			S.Size := S.Size - 1;
			if (S.Size = 0) then
				S.Tail := null;
				S.Head := null;
			else
				S.Head      := C.Next;
				S.Head.Prev := null;
			end if;
			Free(C);
		end if;
	end;

	procedure Pop_Back(S: in out Object) is
		C: Cell_Ref := S.Tail;
	begin
		if C /= null then
			S.Size := S.Size - 1;
			if (S.Size = 0) then
				S.Tail := null;
				S.Head := null;
			else
				S.Tail      := C.Prev;
				S.Tail.Next := null;
			end if;
			Free(C);
		end if;
	end;

	procedure Clear(S: in out Object) is
	begin
		while not Is_Empty(S) loop
			Pop_Front(S);
		end loop;
		S.Size := 0;
	end;

	procedure Push_Front(S: in out Object; A: in Class) is
		C: Cell_Ref := new Cell'(Value => A, Next => S.Head, Prev => null);
	begin
		S.Size := S.Size + 1;
		if (S.Size = 1) then
			S.Tail := C;
		else
			S.Head.Prev := C;
		end if;
		S.Head := C;
	end;

	procedure Push_Back(S: in out Object; A: in Class) is
		C: Cell_Ref := new Cell'(Value => A, Prev => S.Tail, Next => null);
	begin
		S.Size := S.Size + 1;
		if (S.Size = 1) then
			S.Head := C;
		else
			S.Tail.Next := C;
		end if;
		S.Tail := C;
	end;

	function Size(S: in Object) return Natural is (S.Size);

	function First(S: in Object) return Class is
		(S.Head.Value);

	function Last(S: in Object) return Class is
		(S.Tail.Value);

	function Is_Empty(S: in Object) return Boolean is
		(if S.Head = null then true else false);

end List;
