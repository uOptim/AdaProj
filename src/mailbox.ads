generic
	type Message_Type is private;

package Mailbox is

	type Messages is array (Positive range <>) of Message_Type;

	protected type Object(Size: Positive) is
		entry Put(M: Message_Type);
		entry Get(M: out Message_Type);
		function Is_Full  return Boolean;
		function Is_Empty return Boolean;
	private
		Msgs: Messages(1..Size);
		Msgs_Num: Natural  := 0; 
		Get_Idx:  Positive := 1;
		Put_Idx:  Positive := 1;
	end;

end Mailbox;
