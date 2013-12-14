package body Mailbox is

	protected body Object is 

		function Is_Full return Boolean is
			(Msgs_Num = Size);

		function Is_empty return Boolean is
			(Msgs_Num = 0);

		entry Put(M: Message_Type) when not Is_Full is
		begin
			Msgs_Num := Msgs_Num + 1;

			Msgs(Put_Idx) := M;

			if Put_Idx = Msgs'Last then
				Put_Idx := Msgs'First;
			else
				Put_Idx := Put_Idx + 1;
			end if;
		end;

		entry Get(M: out Message_Type) when not Is_Empty is
		begin
			Msgs_Num := Msgs_Num - 1;

			M := Msgs(Get_Idx);

			if Get_Idx = Msgs'Last then
				Get_Idx := Msgs'First;
			else
				Get_Idx := Get_Idx + 1;
			end if;
		end;
	end;

end Mailbox;
