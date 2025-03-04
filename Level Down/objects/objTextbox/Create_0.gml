//variables
page = 0; //should be set to 0 when not testing
drawChar = 0; //how many characters have been drawn
lineWidth = textboxWidth - textBorder*2;
textLength = []; //holds the text length of each page for a given instance
setup = false;

//floor 0
textFloor0 = [];
//Example of multiple dialogues:
//textFloor0[0] = "First dialogue";
//textFloor0[1] = "Second dialogue"; 
//textFloor0[2] = "Third dialogue";
textFloor0[0] = "Welcome, astronaut! Get to the top! That green arrow will take you up! Use WASD or Arrow Keys to move and Space to jump.";

//floor 5
textFloor5 = [];
textFloor5[0] = "Great job! You've reached a checkpoint. The next floors are slippery. Tread carefully! Look out at the stars! They are cheering you on!";

//floor 10
textFloor10 = [];
textFloor10[0] = "Caution ahead! These floors are unstable and will break under your feet. You'll need to be quick to stay ahead!";

//floor 15
textFloor15 = [];
textFloor15[0] = "Impressive work! You're moving up quickly. I think these spaces used to be rooms. The glass walls are all that remain.";

//floor 20
textFloor20 = [];
textFloor20[0] = "Checkpoint reached. Good work, astronaut. Keep moving. There's no telling what comes next.";

//floor 25
textFloor25 = [];
textFloor25[0] = "Another checkpoint. You're okay?! That last floor was collapsing beneath you! The next floor has holographic tiles. They flicker in and out of existence. Watch closely, these tiles blink on and off rhythmically.";

//floor 30
textFloor30 = [];
textFloor30[0] = "Were those trampolines? They must have been experimenting with the unusual gravity.";

//floor 35
textFloor35 = [];
textFloor35[0] = "Thirty-five floors. You're doing so well! Something new is ahead.";

//floor 40
textFloor40 = [];
textFloor40[0] = "Nice jump at the end there! I've been told there's 60 more floors... Does that scare you?";

//floor 45
textFloor45 = [];
textFloor45[0] = "Forty-five floors. This station used to hum with energy. I'm not sure what happened to this place?";

//floor 50
textFloor50[0] = "Halfway point. This is no longer just a climb. Whatever lies ahead has been waiting for a long time.";

//floor 55
textFloor55 = [];
textFloor55[0] = "Feel free to take a break and relax. You are safe on these floors. Look around. The view is spectacular.";

//floor 60
textFloor60 = [];
textFloor60[0] = "Sixty floors. Listen close. What do you hear? Don't stop. The truth is waiting for you.";

//floor 65
textFloor65 = [];
textFloor65[0] = "You haven't seen anyone sprinting through endless tunnels, have you? If you do see an alien sprinting in zero gravity, tell them they're running the wrong way!.";

//floor 70
textFloor70 = [];
textFloor70[0] = "Seventy floors. The next ones look quite difficult. Keep moving, and don't look back.";

//floor 75
textFloor75 = [];
textFloor75[0] = "Checkpoint reached. You're so close now. Whatever's up there... it's ready for you.";

//floor 80
textFloor80 = [];
textFloor80[0] = "Those were some really hard levels. Very impressive! There's a buzzing. I think this part of the station has power.";

//floor 85
textFloor85 = [];
textFloor85[0] = "Eighty-five floors. Almost there, astronaut.";

//floor 90
textFloor90 = [];
textFloor90[0] = "Ninety floors. A rocket ship awaits. You've come this far. Don't give up now.";

//floor 95
textFloor95 = [];
textFloor95[0] = "Ninety-five floors. Just a few more steps. Everything you've done leads to this moment. Make it count.";

//floor 100
textFloor100 = [];
textFloor100[0] = "You've made it! Look at that... It's a rocket ship! This was always the mission, wasn't it? To find the way home. Congratulations, astronaut. You've written your legacy in the stars.";