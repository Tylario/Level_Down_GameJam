if (distance_to_object(objPlayer) <= 100) {
    image_alpha = 1;
} else {
    image_alpha = 0.1;
}

show_debug_message("Distance to player: " + string(distance_to_object(objPlayer)));
