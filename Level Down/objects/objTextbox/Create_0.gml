//variables
page = 0; //should be set to 0 when not testing
drawChar = 0; //how many characters have been drawn
lineWidth = textboxWidth - textBorder*2;
textLength = []; //holds the text length of each page for a given instance
setup = false;

//floor 0
textFloor0 = [];
textFloor0[0] = "Welcome, astronaut! Get to the top! That green arrow will take you up!";


//floor 5
textFloor5 = [];
textFloor5[0] = "Great job! You've reached a checkpoint.";
textFloor5[1] = "The next floors are slippery. Tread carefully!";
textFloor5[2] = "Look at the stars-they're cheering you on!";

//floor 10
textFloor10 = [];
textFloor10[0] = "Caution ahead! These floors are unstable and will break under your feet.";
textFloor10[1] = "You'll need to be quick to stay ahead!";

//floor 15
textFloor15[0] = "Impressive work! You're moving up quickly.";
textFloor15[1] = "I think these spaces used to be rooms. The glass walls are all that remain.";

//floor 20
textFloor20 = [];
textFloor20[0] = "Checkpoint reached. Good work, astronaut.";
textFloor20[1] = "This station once thrived with life. Now, it's just you.";
textFloor20[2] = "Press on, but remember-you're not alone out here.";

//floor 25
textFloor25 = [];
textFloor25[0] = "Another checkpoint. You're okay?! That last floor was collapsing beneath you!";
textFloor25[1] = "Unbreakable, yet unstable. Who designed this place?";
textFloor25[2] = "Keep moving. There's no telling what comes next.";

//floor 30
textFloor30 = [];
textFloor30[0] = "Was that a trampoline? Looks like they were experimenting with the gravity here.";
textFloor30[1] = "This is where the demo ends, but there's so much more ahead.";
textFloor30[2] = "Thank you for playing! The full climb awaits you, astronaut.";


//floor 35
textFloor35 = [];
textFloor35[0] = "Thirty-five floors. You're relentless.";
textFloor35[1] = "The orange suit-it symbolizes hope. Let's make it count.";

//floor 40
textFloor40 = [];
textFloor40[0] = "Nice jump at the end there!";
textFloor40[1] = "You're getting pretty good at this.";
textFloor40[2] = "I've been told there's 60 more levels... does that scare you?";

//floor 45
textFloor45 = [];
textFloor45[0] = "Forty-five floors. This station used to hum with energy.";
textFloor45[1] = "What drained it? Or... who?";

//floor 50
textFloor50[0] = "Halfway point. This is no longer just a climb.";
textFloor50[1] = "Whatever lies ahead has been waiting for a long time.";


//floor 55
textFloor55 = [];
textFloor55[0] = "I keep thinking I'll find something new but all of these floors are completely empty.";
textFloor55[1] = "This was no ordinary evacuation. Keep your guard up.";

//floor 60
textFloor60 = [];
textFloor60[0] = "Sixty floors. The silence here is deafening.";
textFloor60[1] = "Listen close. What do you hear?";
textFloor60[2] = "Don't stop. The truth is waiting for you.";

//floor 65
textFloor65 = [];
textFloor65[0] = "You haven't seen an alien sprinting through endless tunnels, have you?";
textFloor65[1] = "Do you think the others made it this far? I think most have fallen by now.";

//floor 70
textFloor70 = [];
textFloor70[0] = "Seventy floors. Something feels wrong.";
textFloor70[1] = "Keep moving, and don't look back.";

//floor 75
textFloor75 = [];
textFloor75[0] = "Checkpoint reached. You're so close now.";
textFloor75[1] = "Whatever's up there... it knows you're coming.";

//floor 80
textFloor80 = [];
textFloor80[0] = "Those were some really hard levels. Very impressive!";
textFloor80[1] = "There's a buzzing. I think this part of the station has power.";

//floor 85
textFloor85 = [];
textFloor85[0] = "Eighty-five floors. Almost there, astronaut.";
textFloor85[1] = "Each step feels heavier. It's like the station is fighting you.";

//floor 90
textFloor90 = [];
textFloor90[0] = "Ninety floors. The rocket ship awaits.";
textFloor90[1] = "You've come this far. Don't falter now.";

//floor 95
textFloor95 = [];
textFloor95[0] = "Ninety-five floors. Just a few more steps.";
textFloor95[1] = "Everything you've done leads to this moment. Make it count.";

//floor 100
textFloor100 = [];
textFloor100[0] = "You've made it! The rocket ship is here!";
textFloor100[1] = "This was always the mission, wasn't it? To find the way home.";
textFloor100[2] = "Congratulations, astronaut. You've written your legacy in the stars.";
