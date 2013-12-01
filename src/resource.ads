package Resource is

	protected type Object is
		procedure Release;
		entry Acquire;
	private
		Taken: Boolean := False;
	end Object;

	Illegal_Release: exception;
end;
