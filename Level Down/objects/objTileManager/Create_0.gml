var layers = 8;
var xDiff = 49; // Adjust based on the width of your hexagon tiles
var yDiff = 10; // Adjust based on the height difference between the centers of adjacent hexagon tiles

// Adjust this to set the center position
var startX = room_width / 2;
var startY = room_height - 700;

// Function to create a ring of hexagons including the center tile
function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff) {
    // If it's the first layer, create the center tile
    if (layer == 0) {
        var centerTile = instance_create_layer(centerX, centerY, "Instances", hexagonBreakable);
        centerTile.depth = -centerTile.y + 4000;
        show_debug_message(centerTile.y);
        return; // Exit the function after creating the center tile
    }
    
    // Determine the starting position for this layer
    var layerStartX = centerX + layer * xDiff;
    var layerStartY = centerY;
    
    for (var side = 0; side < 6; side++) {
        // Determine the direction to move based on the current side
        var directionX = 0;
        var directionY = 0;
        
        switch (side) {
            case 0: directionX = -xDiff / 2; directionY = yDiff; break;
            case 1: directionX = -xDiff; break;
            case 2: directionX = -xDiff / 2; directionY = -yDiff; break;
            case 3: directionX = xDiff / 2; directionY = -yDiff; break;
            case 4: directionX = xDiff; break;
            case 5: directionX = xDiff / 2; directionY = yDiff; break;
        }
        
        for (var i = 0; i < layer; i++) {
            var posX = layerStartX + i * directionX;
            var posY = layerStartY + i * directionY;
            
            var tileType = hexagonBreakable; // Make it breakable
            
            // Create the tile and set its depth based on its y position
            var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
            tileInstance.depth = -tileInstance.y + 4000;
            show_debug_message(tileInstance.y);
        }
        
        // Update the starting position for the next side
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}

// Create the center tile
create_hexagon_ring(startX, startY, 0, xDiff, yDiff);

// Create layers of tiles
for (var i = 1; i <= layers; i++) {
    create_hexagon_ring(startX, startY, i, xDiff, yDiff);
}
