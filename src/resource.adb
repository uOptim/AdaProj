package body Semaphore is

	protected body Object is
		procedure post is
		begin
			Count := Count + 1;
		end;

		entry wait when Count > 1 is
		begin
			Count := Count - 1;
		end;
	end Object;
end;
