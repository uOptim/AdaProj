package body Robot.Safe_Trajectory is

	overriding procedure Open(
		T: in out Object;
		From: Work_Site.In_Place; To: Work_Site.Out_Place;
		Speed: Float := 100.0
	) is
		M: Resources.Request_Map;
	begin
		Traj.Object(T).Open(From, To, Speed);
		declare
			Places: Traj.Path_Maker.Place_Name_Array := T.Places;
		begin
			-- build the request map
			for I in Resources.Request_Map'Range loop
				M(I) := False;
			end loop;
			for N of Places loop
				M(N) := True;
			end loop;
		end;
		Resources.Acquire(M);
	end;


	overriding procedure Next(T: in out Object; dt: Float) is
	begin
		Traj.Object(T).Next(dt);

		declare
			Places: Traj.Path_Maker.Place_Name_Array := T.Places;
		begin
			for Seg in T.Freed+1 .. T.Segment loop
				if not Traj.Path_Maker.Robot_Intersects(
					Places(Seg),
					Work_Site.Position'(Integer(T.X), Integer(T.Y))
				) then
					Resources.Release(Places(Seg));
					T.Freed := T.Freed + 1;
				end if;
			end loop;

			if T.Is_Done then
				Resources.Release(Places(Places'Last));
			end if;
		end;
	end;


	overriding procedure Close(T: in out Object) is
	begin
		declare
			Places: Traj.Path_Maker.Place_Name_Array := T.Places;
		begin
			if not T.Is_Done then
				for Seg in T.Freed+1 .. Places'Last loop
					Resources.Release(Places(Seg));
				end loop;
			end if;
		end;
		T.Freed := 0;
		Traj.Object(T).Close;
	end;

end;
