//variables
page = 0; //should be set to 0 when not testing
drawChar = 0; //how many characters have been drawn
lineWidth = textboxWidth - textBorder*2;
textLength = []; //holds the text length of each page for a given instance
setup = false;

//floor 0
textFloor0 = [];
textFloor0[0] = "Welcome, astronaut! Get to the top! That green arrow will take you up!";
textFloor0[1] = "Remember, every step counts. The galaxy is watching!";


//floor 5
textFloor5 = [];
textFloor5[0] = "Great job! You've reached a checkpoint.";
textFloor5[1] = "The next floors are slippery. Tread carefully!";
textFloor5[2] = "Look at the stars-they're cheering you on!";

//floor 10
textFloor10 = [];
textFloor10[0] = "Caution ahead! These floors are unstable and will break under your feet.";
textFloor10[1] = "You'll need to be quick to stay ahead!";
textFloor10[2] = "Think fast, move faster. You've got this!";
//floor 15
textFloor15 = [];
textFloor15[0] = "Impressive work! You're moving up quickly.";
textFloor15[1] = "Did you hear that? It's not just the wind... stay alert.";

//floor 20
textFloor20 = [];
textFloor20[0] = "Checkpoint reached. Good work, astronaut.";
textFloor20[1] = "This station once thrived with life. Now, it's just you.";
textFloor20[2] = "Press on, but remember-you're not alone out here.";

//floor 25
textFloor25 = [];
textFloor25[0] = "Twenty-five floors. This was a maintenance hub for the old colony.";
textFloor25[1] = "The air feels... different. Do you notice it too?";

//floor 30
textFloor30 = [];
textFloor30[0] = "Another checkpoint. You're doing great.";
textFloor30[1] = "There are signs of damage here. Something big happened... but what?";
textFloor30[2] = "Keep going. Answers might lie ahead.";

//floor 35
textFloor35 = [];
textFloor35[0] = "Thirty-five floors. You're relentless.";
textFloor35[1] = "The orange suit-it symbolizes hope. Let's make it count.";

//floor 40
textFloor40 = [];
textFloor40[0] = "Checkpoint reached. This place feels ancient.";
textFloor40[1] = "Why did everyone leave? Or... were they forced to?";
textFloor40[2] = "Only 60 more to go. You're closer to the truth.";

//floor 45
textFloor45 = [];
textFloor45[0] = "Forty-five floors. This station used to hum with energy.";
textFloor45[1] = "What drained it? Or... who?";

//floor 50
textFloor50 = [];
textFloor50[0] = "Halfway point. This is no longer just a climb.";
textFloor50[1] = "Something or someone is watching. Can you feel it?";
textFloor50[2] = "The edge of the universe might hold all the answers.";

//floor 55
textFloor55 = [];
textFloor55[0] = "Fifty-five floors. There's debris everywhere.";
textFloor55[1] = "This was no ordinary evacuation. Keep your guard up.";

//floor 60
textFloor60 = [];
textFloor60[0] = "Sixty floors. The silence is deafening.";
textFloor60[1] = "Echoes of the past are loud here. What do you hear?";
textFloor60[2] = "Don't stop. The truth is waiting for you.";

//floor 65
textFloor65 = [];
textFloor65[0] = "Sixty-five floors. Shadows linger here.";
textFloor65[1] = "Do you think the others made it this far? Or did they turn back?";

//floor 70
textFloor70 = [];
textFloor70[0] = "Seventy floors. Something feels wrong.";
textFloor70[1] = "Was that a whisper? Keep moving, and don't look back.";

//floor 75
textFloor75 = [];
textFloor75[0] = "Checkpoint reached. You're so close now.";
textFloor75[1] = "The air is thicker here, heavy with memories.";
textFloor75[2] = "Whatever's up there... it knows you're coming.";

//floor 80
textFloor80 = [];
textFloor80[0] = "Eighty floors. The station's core must be near.";
textFloor80[1] = "Lights flicker. Did you see that? Something moved.";

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
