//variables
page = 0; //should be set to 0 when not testing
drawChar = 0; //how many characters have been drawn
lineWidth = textboxWidth - textBorder*2;
textLength= []; //holds the text length of each page for a given instance
setup = false;

//floor 0
textFloor0 = [];
textFloor0[0] = "this is a test. press \"Z\" to progress dialogue";
textFloor0[1] = "if you need to test the game without the text box, you can make the \"Textbox\" layer invisible in rm_main";
textFloor0[2] = "test 2";

//floor 5
textFloor5 = [];
textFloor5[0] = "";
textFloor5[1] = "floor 5 test";

//floor 10
textFloor10 = [];
textFloor10[0] = "";
textFloor10[1] = "floor 10 test";