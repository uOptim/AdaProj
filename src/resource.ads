package Semaphore is

	protected type Object is
		procedure post;
		entry wait;
	private
		Count: Natural := 0;
	end Object;

end;
