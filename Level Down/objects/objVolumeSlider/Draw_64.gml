// Draw the slider bar
draw_set_colour(#cccccc); // Set to a modern grey color for the bar
draw_rectangle(x, y, x + width, y + height, false);

// Draw the square slider handle
draw_set_colour(#999999); // Set the handle color to a darker grey for contrast
var handle_center_y = y + height / 2; // Center of the handle vertically
var square_side = handle_height; // Assuming you want the square's height to match the original circle's diameter
draw_rectangle(handle_x, handle_center_y - square_side / 2, handle_x + square_side, handle_center_y + square_side / 2, false);

// Draw the music logo using the sprMusic sprite, scaled to twice its original size
var logo_x = x - 35; // x-coordinate for the logo
var logo_y = y + (height / 2) - (sprite_get_height(sprMusic) * 2 / 2); // Center logo vertically based on the scaled height of the sprite
draw_sprite_ext(sprMusic, 0, logo_x, logo_y, 2.2, 2.2, 0, c_white, 1); // Scale both horizontally and vertically by 2
