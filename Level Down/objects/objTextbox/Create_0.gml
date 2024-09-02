//setup
draw_set_font(fntHabbo);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

//current page
page = 1=0; //should be set to 0 when not testing

//floor pages

//floor 0
textFloor0 = [];
textFloor0[0] = "if you need to test the game without the text box, you can \nmake the \"Textbox\" layer invisible in rm_main";
textFloor0[1] = "test";


//floor 5
textFloor5 = [];
textFloor5[0] = "";
textFloor5[1] = "floor 5 test";


//floor 10
textFloor10 = [];
textFloor10[0] = "";
textFloor10[1] = "floor 10 test";

//npc test
instance_create_layer(990, 14623, "Instances", objNPC);
