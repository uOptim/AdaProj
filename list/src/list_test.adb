with List;
with List.Print;
with Ada.Text_IO;

procedure List_test is
	package IO renames Ada.Text_IO;
	package Int_List  is new List(Integer);
	package Char_List is new List(Character);

	procedure Print_Int_List  is new Int_List.Print(Integer'Image);
	procedure Print_Char_List is new Char_List.Print(Character'Image);

	I: Int_List.Object;
	C: Char_List.Object;
begin
	Char_List.Push_Front(C, 'a');
	Char_List.Push_Back(C, 'b');
	Print_Char_List(C);
	IO.New_Line;

	Int_List.Push_Front(I, 10);
	Int_List.Push_Back(I, 14);
	Print_Int_List(I);
	IO.New_Line;

	Int_List.Pop_Back(I);
	Int_List.Push_Front(I, 4);
	Print_Int_List(I);
	IO.New_Line;

	Int_List.Pop_Front(I);
	Int_List.Pop_Front(I);
	Int_List.Pop_Back(I);
	Int_List.Pop_Back(I);
	Int_List.Pop_Back(I);
	Int_List.Push_Front(I, 1);
	Int_List.Push_Front(I, 1);
	Int_List.Push_Front(I, 1);
	Print_Int_List(I);
	IO.New_Line;

	Char_List.Clear(C);
	Int_List.Clear(I);

	IO.Put_Line("OK.");
end;
