package body Generic_Resource_Pool is

	procedure Acquire(Map: Request_Map) is
	begin
		for ID in Resource_ID'First..Resource_ID'Last loop
			if Map(ID) then Acquire(ID); end if;
		end loop;
	end;

	procedure Acquire(ID: Resource_ID) is
	begin
		Resource_Pool(ID).Acquire;
	end;

	procedure Release(Map: Request_Map) is
	begin
		for ID in Resource_ID'First..Resource_ID'Last loop
			if Map(ID) then Release(ID); end if;
		end loop;
	end;

	procedure Release(ID: Resource_ID) is
	begin
		Resource_Pool(ID).Release;
	end;

	protected body Resource is
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
	end Resource;
end;
