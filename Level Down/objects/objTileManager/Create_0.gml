lastFloor = -1;


function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) {
    centerY -= floorNum * floorHeight;
   
    if (layer == 0) 
	{
	    var centerTileType = determineTileType(floorNum, centerX, centerY); // Assuming centerX and centerY passed correctly
	    if (centerTileType != noone) {
	        var centerTile = instance_create_layer(centerX, centerY, "Instances", centerTileType);
	        // Adjusted depth calculation to match other tiles
	        centerTile.depth = (-centerTile.y * 2) + 4000 - (floorNum * 50);
	        centerTile.floorNumber = floorNum;
	    }
	    return;
	}
   
    var layerStartX = centerX + layer * xDiff;
    var layerStartY = centerY;
   
    for (var side = 0; side < 6; side++) {
        var directionX = 0, directionY = 0;
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
           
            // Now passing posX and posY
            var tileType = determineTileType(floorNum, posX, posY);

            if (tileType != noone) { 
                var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
                tileInstance.depth = (-tileInstance.y * 2) + 4000 - (floorNum * 50);
                tileInstance.floorNumber = floorNum;
            }
        }
       
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}



function determineTileType(floorNum, posX, posY) {
	
	var message = "Floor Number: " + string(floorNum) + ", posX: " + string(posX) + ", posY: " + string(posY);
    show_debug_message(message);
	
	var level0TrampolineX = 777.50, level0TrampolineY = 2470;
	var level1TrampolineX = 1096, level1TrampolineY = 2380;
	var level2TrampolineX = 581.50, level2TrampolineY = 2250;
	var level3TrampolineX = 1194, level3TrampolineY = 2160;
	var level4TrampolineX = 1022.50, level4TrampolineY = 2090;
	var level5TrampolineX = 998, level5TrampolineY = 1840;
	
	
    var tileType = noone;
    var randomNumber = irandom(100); // Random number for each tile
    var floorHeight = 100; // Height difference between floors

    // Checking for a trampoline in the same position on the previous floor
    if (floorNum > 0) {
        var belowPosY = posY + floorHeight; // Calculate the Y position of the tile directly below on the previous floor
        // This checks for a trampoline below and sets this tile to unbreakable if found
        var belowTileType = determineTileType(floorNum - 1, posX, belowPosY);
        if (belowTileType == hexagonTrampoline) {
			//show_debug_message(message);
            return objHexagonUnbreakable; // Force this tile to be an unbreakable hexagon
        }
    }

    // Use the previously defined variables for trampoline positions
    switch(floorNum) {
        case 0:
            tileType = objHexagonUnbreakable;
            if (posX == level0TrampolineX && posY == level0TrampolineY) {
                tileType = hexagonTrampoline;
            }
            break;
        case 1:
            if (randomNumber < 90) { 
                tileType = hexagonBreakable;
            }
            if (randomNumber < 3) { 
                tileType = hexagonArrow;
            }
            if (posX == level1TrampolineX && posY == level1TrampolineY) {
                tileType = hexagonTrampoline;
            }
            break;
        case 2:
            if (randomNumber < 90) {
                tileType = hexagonIce; 
            }
            if (posX == level2TrampolineX && posY == level2TrampolineY) {
                tileType = hexagonTrampoline;
            }
            break;
        case 3:
            if (randomNumber < 60) { 
                tileType = hexagonBreakable;
            }
            if (posX == level3TrampolineX && posY == level3TrampolineY) {
                tileType = hexagonTrampoline;
            }
            break;
        case 4:
            if (randomNumber < 50) { 
                tileType = hexagonIce;
            }
            if (randomNumber < 15) { 
                tileType = hexagonArrow;
            }
            if (randomNumber < 15) { 
                tileType = hexagonBreakable;
            }
            if (posX == level4TrampolineX && posY == level4TrampolineY) {
                tileType = hexagonTrampoline;
            }
            break;
        case 5:
            if (randomNumber < 55) { 
                tileType = hexagonIce;
            }
            if (posX == level5TrampolineX && posY == level5TrampolineY) {
                tileType = hexagonTrampoline;
            }
            break;
        case 6:
            tileType = hexagonArrow;
            break;
        case 7:
            tileType = hexagonBreakable;
            break;
        default:
            tileType = hexagonArrow;
    }

    return tileType;
}




function destroyTileLayer(floorNum) {
    with (objParentHexagon) { 
        if (floorNumber > floorNum) {
            instance_destroy();
        }
    }
}


var layers = 11;
var floors = 7; 
var xDiff = 49; 
var yDiff = 10; 
var floorHeight = 100; // Height difference between floors

// Adjust this to set the center position
var startX = room_width / 2;
var startY = room_height - 400;
    
// Destroy all hexagons before creating new ones
with (objParentHexagon) 
{
	if (floorNumber > objPlayer.currentFloor)
	{
		instance_destroy();
	}
}

// Loop to create each floor
for (var floorNum = 0; floorNum < floors; floorNum++) 
{
	if (floorNum == 0)
	{
		layers = 14;
	}
	else
	{
		layers = 11;
	}
    for (var i = 0; i <= layers; i++) 
	{
        create_hexagon_ring(startX, startY, i, xDiff, yDiff, floorNum, floorHeight);
    }
}