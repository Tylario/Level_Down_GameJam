interactKey = keyboard_check_pressed(ord("z"));

textboxX = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2) - textboxWidth / 2;
textboxY = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 1.7);

draw_sprite_stretched(sprTextbox, image_index, textboxX, textboxY, textboxWidth, textboxHeight);

//test printing text
draw_text_transformed(textboxX + textBorderX, textboxY + textBorderY, textFloor(page), textScale, textScale, 0);
