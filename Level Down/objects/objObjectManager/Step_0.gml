// Check if the floor has changed
if (objPlayer.currentFloor != lastFloor) 
{
    show_debug_message("Player moved to floor: " + string(objPlayer.currentFloor));

    if (objPlayer.currentFloor < 0)
    {
        objPlayer.currentFloor = 0;
        objPlayer.x = 1152; // Starting X position on the first floor
        objPlayer.y = 14572; // Starting Y position on the first floor
    }

    // Save current floor in an INI file
    var ini_file;
    ini_file = ini_open("save.ini");
    ini_write_real("SaveData", "LevelNumber", objPlayer.currentFloor);
    ini_close();

    if (objPlayer.currentFloor == 100)
    {
        objGameReset.image_alpha = 1;
    }
    else
    {
        objGameReset.image_alpha = 0;
    }

    var ringCount = 11; // Default ring count for hexagon creation
    var xDiff = 48;  // X offset for hexagon creation
    var yDiff = 10.5; // Y offset for hexagon creation
    var floorHeight = 100; // Height difference between floors

    // NPC and Dialogue Indicator positions based on checkpoint floors
    var objNPC_instance = instance_find(objNPC, 0);
    var objDialogueIndicator_instance = instance_find(objDialogueIndicator, 0);
    if (objPlayer.currentFloor % 5 == 0)
    {
        objNPC_instance.x = 990;
        objNPC_instance.y = 14623 - floorHeight * objPlayer.currentFloor;
        objDialogueIndicator_instance.x = 989;
        objDialogueIndicator_instance.y = 14571 - floorHeight * objPlayer.currentFloor;
    }
    else
    {
        objNPC_instance.x = 192; // Default position if not a checkpoint floor
        objNPC_instance.y = 0;
        objDialogueIndicator_instance.x = 192;
        objDialogueIndicator_instance.y = 0;
    }

    var startX = room_width / 2; // Center X for hexagon rings
    var startY = room_height - 400; // Center Y for hexagon rings

    with (objParentHexagon) 
    { 
        instance_destroy();
    }

    if (renderTwoLayers)
    {
        for (var f = max(0, objPlayer.currentFloor - 1); f <= objPlayer.currentFloor; f++) 
        {
            for (var i = 0; i <= ringCount; i++) 
            {
                create_hexagon_ring(startX, startY, i, xDiff, yDiff, f, floorHeight);
            }
        }
    }
    else
    {
        for (var i = 0; i <= ringCount; i++) 
        {
            create_hexagon_ring(startX, startY, i, xDiff, yDiff, objPlayer.currentFloor, floorHeight);
        }
    }

    // Destroy tiles of floors below the current one
    if (objPlayer.currentFloor != -1) {
        destroyTileLayer(objPlayer.currentFloor);
    }

    // Log player movement if falling from a checkpoint level to a target level
    if (lastFloor % 5 == 0 && objPlayer.currentFloor % 5 == 4)
    {
        var oldX = objPlayer.x;
        var oldY = objPlayer.y;

        // Move player towards the center of the floor
        objPlayer.x = lerp(oldX, startX, 0.5);
        objPlayer.y = lerp(oldY, startY - objPlayer.currentFloor * floorHeight, 0.5);

    }
}

// Update lastFloor after all other logic
lastFloor = objPlayer.currentFloor;

if (renderTwoLayers) 
{
    with (objParentHexagon) 
    {
        if (floorNumber != objPlayer.currentFloor) 
        {
            image_blend = make_color_rgb(100, 100, 100); // Dark gray for non-current floors
            image_alpha = 0.5;
        } 
        else 
        {
            image_blend = c_white; // White for the current floor
            image_alpha = 1;
        }
    }
}