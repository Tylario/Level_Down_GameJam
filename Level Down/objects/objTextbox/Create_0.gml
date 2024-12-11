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
textFloor10[1] = "You’ll need to be quick to stay ahead!";
textFloor10[2] = "Think fast, move faster. You've got this!";

//floor 15
textFloor15 = [];
textFloor15[0] = "Impressive work! You're moving like a comet!";
textFloor15[1] = "The space winds grow stronger from here. Stay focused.";
textFloor15[2] = "The stars are closer now-can you feel it?";

//floor 20
textFloor20 = [];
textFloor20[0] = "Checkpoint reached! Take a deep breath.";
textFloor20[1] = "The void is vast, but so is your determination.";
textFloor20[2] = "Brace yourself-the journey gets tougher from here.";

//floor 25
textFloor25 = [];
textFloor25[0] = "Twenty-five floors! You're halfway to the stars.";
textFloor25[1] = "The floors ahead may twist and turn-watch your step.";

//floor 30
textFloor30 = [];
textFloor30[0] = "You've made it to another checkpoint!";
textFloor30[1] = "Asteroids might pass close here-keep an eye out!";
textFloor30[2] = "Your courage is an inspiration to the galaxy!";

//floor 35
textFloor35 = [];
textFloor35[0] = "Thirty-five floors, and you're still going strong!";
textFloor35[1] = "Your orange suit shines brighter than ever-let's keep it that way.";

//floor 40
textFloor40 = [];
textFloor40[0] = "Checkpoint reached! The stars applaud your persistence.";
textFloor40[1] = "It’s getting colder as you ascend. Stay sharp.";
textFloor40[2] = "Only 60 more to go-easy, right?";

//floor 45
textFloor45 = [];
textFloor45[0] = "Forty-five floors! Your journey is halfway through the void.";
textFloor45[1] = "Careful now-the floors may play tricks on you.";

//floor 50
textFloor50 = [];
textFloor50[0] = "Congratulations! You're at the halfway point.";
textFloor50[1] = "The stars are rooting for you. Don’t let up now!";
textFloor50[2] = "From here on, you’re chasing the edge of the universe!";

//floor 55
textFloor55 = [];
textFloor55[0] = "Fifty-five floors! Your stamina is incredible.";
textFloor55[1] = "The void whispers-can you hear it cheering?";

//floor 60
textFloor60 = [];
textFloor60[0] = "Sixty floors! This is where true legends shine.";
textFloor60[1] = "Every step takes you closer to the stars.";
textFloor60[2] = "Don’t look down-focus on the journey ahead!";

//floor 65
textFloor65 = [];
textFloor65[0] = "Sixty-five floors! You’re defying gravity itself!";
textFloor65[1] = "Feel the pull of the stars-they’re calling you home.";

//floor 70
textFloor70 = [];
textFloor70[0] = "Seventy floors! The air feels electric up here.";
textFloor70[1] = "Keep going. The galaxy believes in you!";

//floor 75
textFloor75 = [];
textFloor75[0] = "Checkpoint reached! Only 25 more to go!";
textFloor75[1] = "The void is vast, but your will is greater.";
textFloor75[2] = "Let’s make this climb unforgettable!";

//floor 80
textFloor80 = [];
textFloor80[0] = "Eighty floors! The final stretch begins.";
textFloor80[1] = "Stars glimmer brighter-they know you’re close!";

//floor 85
textFloor85 = [];
textFloor85[0] = "Eighty-five floors! The finish line is near.";
textFloor85[1] = "The stars seem close enough to touch. Keep going!";

//floor 90
textFloor90 = [];
textFloor90[0] = "Ninety floors! You’re almost there!";
textFloor90[1] = "The rocket ship awaits. The universe is within your reach!";

//floor 95
textFloor95 = [];
textFloor95[0] = "Ninety-five floors! One final push!";
textFloor95[1] = "The stars are within your grasp. You can do this!";

//floor 100
textFloor100 = [];
textFloor100[0] = "You’ve made it! The rocket ship is here!";
textFloor100[1] = "Step inside, and the universe is yours.";
textFloor100[2] = "Congratulations, astronaut-you’ve reached the stars!";