if (breaking)
{
    // Check only once if the player is colliding more than 50% with the object.
    if (!variable_instance_exists(id, "checkedForCollision"))
    {
        var playerInstance = instance_place(x, y, objPlayer);
        if (playerInstance != noone)
        {
            var playerMaskWidth = sprite_get_width(playerInstance.sprite_index);
            var playerMaskHeight = sprite_get_height(playerInstance.sprite_index);
            var overlapArea = collision_rectangle(x - bbox_left, y - bbox_top, x + bbox_right, y + bbox_bottom, objPlayer, false, true);

            if (overlapArea != noone)
            {
                var hexagonArea = bbox_right * bbox_bottom;
                var overlapWidth = min(bbox_right, playerInstance.x + playerMaskWidth) - max(bbox_left, playerInstance.x);
                var overlapHeight = min(bbox_bottom, playerInstance.y + playerMaskHeight) - max(bbox_top, playerInstance.y);
                var collisionPercentage = (overlapWidth * overlapHeight) / hexagonArea;

                if (collisionPercentage > 0.5)
                {
                    // Player falling code goes here
                    show_debug_message("player falling");

                    variable_instance_add(id, "checkedForCollision", true);
                }
            }
        }
    }

    fallingTime -= delta_time / 1000000;
    
    if (fallingTime <= 0)
    {
        instance_destroy();
    }
    else
    {
        var seconds = delta_time / 1000000;
        currentSpeed += fallingAcceleration * seconds;
        y += currentSpeed;
    }
}
