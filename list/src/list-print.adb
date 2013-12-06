with Ada.Text_IO;

procedure List.Print(S: in List.Object) is
	package IO renames Ada.Text_IO;

	C: Cell_Ref := S.Head;
begin
	while C /= null loop
		IO.Put_Line(Image(C.Value));
		C := C.Next;
	end loop;
end;
