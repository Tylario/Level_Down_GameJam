var dwidth = display_get_width()
var dheight = display_get_height()

//window_set_size(dwidth, dheight);

var cam = view_get_camera(0);
//camera_set_view_size(cam, dwidth*.3, dheight*.3);


//display_set_gui_size(window_get_width()/2, window_get_height()/2);

/*

the room is currently trying to display a 480x720 pixel view surrounding the character at a resolution of 
1920x1080. when using a normal sized monior, the windows export runs normally. when using a browser, the
game is attempting to display the camera view at 1920x1080 (which is causing overflow bars to appear).

the camera dimensions must have a corresponding ratio to the viewpost, or the image will appear warped.
for the game to properly fill the browser, both the camera and viewport need to be adjusted.

when using the display_get_width/heigh functions (in html5, this function returns the width/height of the 
browser window) to set the viewport, there is still overflow (no matter the camera size). i just changed a 
game setting and made it so the game is centered in the browser when ran. this removes the overflow. the 
sprites are slightly warped. there are black bars on the sides of the screen where the camera does not
reach.

changing the camera is weird. the camera is currently set at 480x720. i think the solution to the camera 
would be finding a way to scale it dynamically (based on the size of the window itself). however, i don't 
know how to do that while maintaining the aspect ratio (it has just occured to me that i can ensure the 
camera dimension maintain the correct aspect ratio by scaling the display_get function (which is the 
exact values being used to set the viewport dimensions)). it seems like the camera size and the viewport
size need to both be changed dynamically in such a way that guarentees that they are proper ratios
of eachother.

i tried this and the visuals were very warped and the black bars were still present... i went to the 
game settings and set the ratio to "full scale" which made the warping less intense (but still a problem) 
and removed the black bars. now the overflow bars are back??? from where??? once again, the centereing 
setting has gotten rid of the overflow (somehow)

ok i now have the correct width and height for the camera view, but the sprites look slightly fucked 
up and i do not know why. the camera is created with scalars of the viewport dimensions. i created 
variables for the width and height of the display in case calling the function at different times was 
screwing the values up but it changed nothing.

i think the reason the "keep aspect ratio" is creating black bars is because the room dimensions are set 
as soon as the game starts. even though i am modifying them in here instantly, the starting values are 
still the same. i have no clue as to why having the "center window" option on gets rid of the overflow.

when i don't adjust the camera, the game display is squished, but the assets are normal otherwise.

update: i am a moron. the aspect ratio of the camera HAS to fit with the sprites (which is why it was 
not working before). the original camera size has the correct ratio, but is getting compressed because 
of something (i would assume the viewport).

so the next big question is what dimensions does the camera need to not ruin the sprites.

*/

