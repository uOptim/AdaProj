with Ada.Text_IO;

package body Robot.Trajectory is
	package IO renames Ada.Text_IO;

	function X(T: Object) return Float is
		(if T.Done then 0.0 else Path.X(T.Route, T.Segment, T.K));

	function Y(T: Object) return Float is
		(if T.Done then 0.0 else Path.Y(T.Route, T.Segment, T.K));

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
			-- debug print
			IO.Put_Line("segment #" & Positive'Image(T.Segment));
		end loop;

		if T.Segment > Path.Segment_Count(T.Route) then
			T.Done := True;
		end if;
	end;

	function At_End(T: Object) return Boolean is
		Count: Natural := Path.Segment_Count(T.Route);
	begin
		if Count = T.Segment and then T.K >= 1.0 then
			return true;
		else
			return false;
		end if;
	end;

	procedure Open(T: in out Object; P: Path.Object; Speed: Float) is
	begin
		if Path.Segment_Count(P) = 0 then
			raise Illegal_Path;
		end if;
		T.K       := 0.0;
		T.Done    := False;
		T.Speed   := Speed;
		T.Segment := 1;
		T.Route   := P;
	end;

	procedure Close(T: in out Object) is
	begin
		T.K       := 0.0;
		T.Done    := False;
		T.Speed   := 5.0;
		T.Segment := 1;
		T.Route   := Path.Null_Path;
	end;
end;
