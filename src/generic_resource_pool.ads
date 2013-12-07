generic
	type Resource_ID is (<>);

package Generic_Resource_Pool is

	type Request_Map is array(Resource_ID) of Boolean;

	procedure Acquire(Map: Request_Map);
	procedure Acquire(ID:  Resource_ID);
	procedure Release(Map: Request_Map);
	procedure Release(ID:  Resource_ID);

private

	protected type Resource is
		procedure Release;
		entry Acquire;
	private
		Taken: Boolean := False;
	end Resource;

	Resource_Pool: array(Resource_ID) of Resource;
end;
