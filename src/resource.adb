package body Resource is

	protected body Object is
		procedure Release is
		begin
			if (Taken = False) then
				raise Illegal_Release;
			end if;
			Taken := False;
		end;

		entry Acquire when not Taken is
		begin
			Taken := True;
		end;
	end Object;
end;
