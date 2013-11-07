with Ada.Text_IO;

package body Robot.Trajectory is
	package IO renames Ada.Text_IO;

	function X(T: Object) return Float is
		(Path.X(T.Route, T.Segment, T.K));

	function Y(T: Object) return Float is
		(Path.Y(T.Route, T.Segment, T.K));

	function Route(T: Object) return Path.Object is
		(T.Route);

	procedure Next(T: in out Object; dt: Float) is
		dK: Float;
	begin
		if T.Done then return; end if;

		dk  := (T.Speed / Path.Segment_Length(T.Route, T.Segment)) * dt;
		T.K := T.K + dK;
		while T.K > 1.0 loop
			T.K       := T.K - 1.0;
			T.Segment := T.Segment + 1;
		end loop;

		if T.Segment > Path.Segment_Count(T.Route) then
			T.Done    := True;
			T.K       := 1.0;  -- in case we went too far
			T.Segment := Path.Segment_Count(T.Route);
		end if;
	end;

	function At_End(T: Object) return Boolean is
		(T.Done);

	procedure Open(T: in out Object; P: Path.Object; Speed: Float) is
	begin
		if Path.Segment_Count(P) = 0 then
			raise Illegal_Path;
		end if;
		Reset(T);
		T.Route := P;
		T.Speed := Speed;
	end;

	procedure Close(T: in out Object) is
	begin
		-- Reset(T);
		T.Done := True;
	end;

	-- private functions and procedures

	procedure Reset(T: in out Object) is
	begin
		T.K       := 0.0;
		T.Done    := False;
		T.Speed   := 5.0;
		T.Segment := 1;
		T.Route   := Path.Null_Path;
	end;
end;
