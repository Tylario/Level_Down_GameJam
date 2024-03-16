var layers = 11;
var floors = 3; // Number of floors to create
var xDiff = 49; // Adjust based on the width of your hexagon tiles
var yDiff = 10; // Adjust based on the height difference between the centers of adjacent hexagon tiles
var floorHeight = 200; // Height difference between floors

// Adjust this to set the center position
var startX = room_width / 2;
var startY = room_height - 400;

// Function to create a ring of hexagons including the center tile, now also accepts floorHeight
function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) {
    // Adjust centerY based on the floor number and floorHeight
    centerY -= floorNum * floorHeight;

    // If it's the first layer, create the center tile
    if (layer == 0) {
        var centerTile = instance_create_layer(centerX, centerY, "Instances", hexagonBreakable);
        // Adjust depth based on floor number, ensuring proper rendering order
        centerTile.depth = -centerTile.y + 4000 - (floorNum * 1000); 
        show_debug_message(centerTile.y);
        return; // Exit the function after creating the center tile
    }
    
    // Determine the starting position for this layer
    var layerStartX = centerX + layer * xDiff;
    var layerStartY = centerY;
    
    for (var side = 0; side < 6; side++) {
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
            
            var tileType = hexagonBreakable; // Specify tile type
            
            // Create the tile and adjust its depth for rendering order
            var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
            tileInstance.depth = -tileInstance.y + 4000 - (floorNum * 1000);
            show_debug_message(tileInstance.y);
        }
        
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}

// Loop to create each floor
for (var floorNum = 0; floorNum < floors; floorNum++) {
    // Create the center tile for each floor
    create_hexagon_ring(startX, startY, 0, xDiff, yDiff, floorNum, floorHeight);

    // Create layers of tiles for each floor
    for (var i = 1; i <= layers; i++) {
        create_hexagon_ring(startX, startY, i, xDiff, yDiff, floorNum, floorHeight);
    }
}
