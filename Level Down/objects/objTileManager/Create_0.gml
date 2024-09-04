lastFloor = -1;


function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) 
{
    centerY -= floorNum * floorHeight;
   
    if (layer == 0) {
        var centerTileType = determineTileType(floorNum, centerX, centerY); // Assuming centerX and centerY passed correctly
        if (centerTileType != noone) {
            var centerTile = instance_create_layer(centerX, centerY, "Instances", centerTileType);
            centerTile.depth = (-centerTile.y * 2) + 34000 - (floorNum * 50);
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
           
            // Determine if this is the outermost layer on floor 0
            var isOutermostLayerOnFloor0;
			
		if (floorNum == 0 && (layer == 14 or layer == 13)) {
		    isOutermostLayerOnFloor0 = true;
		} else {
		    isOutermostLayerOnFloor0 = false;
		}
			
			if (floorNum % 5 == 0)
			{
				// checkpoint level
				if (layer == 16 or layer == 15)
				{
					var tileType = hexagonWall;
				}
				else
				{
					var tileType = determineTileType(floorNum, posX, posY);
				}
			}
			else
			{
				//non checkpoint level
				if (layer == 12 or layer == 13)
				{
					var tileType = noone;
				}
				else if (layer == 14 or layer == 15)
				{
					//var tileType = hexagonInvisibleWall
					var tileType = hexagonWall
				}
				else
				{
					var tileType = determineTileType(floorNum, posX, posY);
				}
			}

            if (tileType != noone) { 
                var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
                tileInstance.depth = (-tileInstance.y * 2) + 34000 - (floorNum * 50);
                tileInstance.floorNumber = floorNum;		

            }
        }
       
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}

crackedChance = 0
trampolineChance = 0
arrowChance = 0
wallChance = 0
breakableChance = 0
unbreakableChance = 0
iceChance = 0
fallChance = 0

function determineTileType(floorNum, posX, posY, isCheckingBelow = false) 
{
	var tileType = noone; // Default to no tile type

    // Adjust trampoline positioning logic for floor height
    var floorHeight = 100; // Height difference between floors
    var adjustedFloorHeight = floorHeight * floorNum; // Adjust for current floorNum

	
    var trampolineX, trampolineY;
    if (floorNum % 2 == 0) { // Alternating trampoline positions based on even or odd floorNum
        trampolineX = 900 - (48 * 5) 
        trampolineY = 14600 - adjustedFloorHeight; 
    } else {
        trampolineX = 900 + (48 * 5);
        trampolineY = 14600 - adjustedFloorHeight;
    }


	// Check for trampolines below if not already checking below (to prevent infinite recursion)
    if (floorNum > 0 && !isCheckingBelow) {
        var xDiff = 48; 
        var yDiff = 10.5;
        
        var belowPosY = posY + floorHeight; // Calculate the Y position of the tile directly below on the previous floor
        var isTrampolineBelow = false;

        // Modify these checks to pass 'true' for the isCheckingBelow parameter
        if (determineTileType(floorNum - 1, posX, belowPosY, true) == hexagonTrampoline) {
            return hexagonFloorNumber;
        } else if (determineTileType(floorNum - 1, posX - xDiff / 2, belowPosY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX + xDiff / 2, belowPosY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX, belowPosY + yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX, belowPosY - yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX - xDiff / 2, belowPosY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX + xDiff / 2, belowPosY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        }
		
		if (determineTileType(floorNum, posX - xDiff / 2, posY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX + xDiff / 2, posY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX, posY + yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX, posY - yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX - xDiff / 2, posY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX + xDiff / 2, posY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        }

        if (isTrampolineBelow) {
            // Ensure unbreakable tiles are spawned above trampolines
            // No additional check required here as isTrampolineBelow flag covers it
            return objHexagonUnbreakable; // Force this tile to be an unbreakable hexagon
        }
    }
	
	// Ensuring trampoline spawns on each floor based on adjusted trampolineX and trampolineY positions
    if (posX == trampolineX && posY == trampolineY) {
        return hexagonTrampoline;
    }
	
	if (floorNum % 5 == 0) 
	{
		if (layer > 5)
		{
			return noone
		}
		else
		{
			return hexagonUnbreakable;
		}
	}

	//Level design / Tile Generation Starts here
	switch (floorNum) {
		case 0:
			tileType = hexagonUnbreakable;
			break;
		case 1:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.16, posX, posY, floorNum, 57, 0.3, hexagonUnbreakable, "inner");
			break;
		case 2:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.18, posX, posY, floorNum, 0, 0.84, hexagonUnbreakable, "inner");
			break;
		case 3:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.32, posX, posY, floorNum, 0, 0.5, hexagonUnbreakable, "inner");
			break;
		case 4:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0, posX, posY, floorNum, 0, 0.59, hexagonBreakable, "half");
			break;
		case 5:
			tileType = hexagonUnbreakable;
			break;
		case 6:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.05
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.15, posX, posY, floorNum, 0, 0.37, hexagonUnbreakable, "inner");
			break;
		case 7:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.05
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.38, posX, posY, floorNum, 0, 0.52, hexagonBreakable, "outer");
			break;
		case 8:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 2
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.20, posX, posY, floorNum, 0, 0.46, hexagonUnbreakable, "inner");
			break;
		case 9:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.3
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.33, posX, posY, floorNum, 0, 0.49, hexagonBreakable, "half");
			break;
		case 10:
			tileType = hexagonUnbreakable;
			break;
		case 11:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.25, posX, posY, floorNum, 0, 0.48, hexagonIce, "inner");
			break;
		case 12:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.35, posX, posY, floorNum, 0, 0.44, hexagonIce, "outer");
			break;
		case 13:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.05
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.35, posX, posY, floorNum, 0, 0.56, hexagonIce, "half");
			break;
		case 14:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.3
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.26, posX, posY, floorNum, 0, 0.53, hexagonIce, "inner");
			break;
		case 15:
			tileType = hexagonUnbreakable;
			break;
		case 16:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.1
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.50, posX, posY, floorNum, 0, 0.70, hexagonUnbreakable, "outer");
			break;
		case 17:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.13
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0, posX, posY, floorNum, 0, 0.21, hexagonUnbreakable, "inner");
			break;
		case 18:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.29, posX, posY, floorNum, 0, 0.62, hexagonIce, "half");
			break;
		case 19:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.2
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.41, posX, posY, floorNum, 0, 0.33, hexagonBreakable, "inner");
			break;
		case 20:
			tileType = hexagonUnbreakable;
			break;
		case 21:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0.075
			tileType = perlinLevelGeneration(0.34, posX, posY, floorNum, 0, 0.57, hexagonUnbreakable, "outer");
			break;
		case 22:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.03
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.44, posX, posY, floorNum, 0, 0.28, hexagonBreakable, "half");
			break;
		case 23:
			crackedChance = 0
			trampolineChance = 0.01
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.3
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.36, posX, posY, floorNum, 0, 0.73, hexagonIce, "inner");
			break;
		case 24:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.1
			wallChance = 0.1
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.42, posX, posY, floorNum, 0, 0.35, hexagonRandomFall, "inner");
			break;
		case 25:
			tileType = hexagonUnbreakable;
			break;
		case 26:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.25
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.39, posX, posY, floorNum, 0, 0.47, hexagonUnbreakable, "half");
			break;
		case 27:
			crackedChance = 0.003
			trampolineChance = 0
			arrowChance = 0.1
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0.2
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.48, posX, posY, floorNum, 0, 0.51, hexagonBreakable, "outer");
			break;
		case 28:
			crackedChance = 0
			trampolineChance = 0.008
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.35, posX, posY, floorNum, 0, 0.60, hexagonIce, "inner");
			break;
		case 29:
			crackedChance = 0.05
			trampolineChance = 0.008
			arrowChance = 0
			wallChance = 0.2
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0.5
			fallChance = 1
			tileType = perlinLevelGeneration(0.46, posX, posY, floorNum, 1, 0.16, hexagonRandomFall, "half");
			break;
		case 30:
			tileType = hexagonUnbreakable;
			break;
		case 31:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.2
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.43, posX, posY, floorNum, 0, 0.54, hexagonBreakable, "inner");
			break;
		case 32:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.4
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0.5
			fallChance = 0
			tileType = perlinLevelGeneration(0.25, posX, posY, floorNum, 0, 0.38, hexagonBreakable, "outer");
			break;
		case 33:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.2
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.47, posX, posY, floorNum, 0, 0.78, hexagonIce, "half");
			break;
		case 34:
			crackedChance = 0
			trampolineChance = 0.0014
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.52, posX, posY, floorNum, 0, 0.45, hexagonRandomFall, "inner");
			break;
		case 35:
			tileType = hexagonUnbreakable;
			break;
		case 36:
			crackedChance = 0.002
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 0.2
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.45, posX, posY, floorNum, 0, 0.11, hexagonUnbreakable, "outer");
			break;
		case 37:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.3
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.55, posX, posY, floorNum, 0, 0.64, hexagonBreakable, "half");
			break;
		case 38:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.7
			wallChance = 0.1
			breakableChance = 0
			unbreakableChance = 0.05
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.49, posX, posY, floorNum, 0, 0.66, hexagonIce, "inner");
			break;
		case 39:
			crackedChance = 0.002
			trampolineChance = 0
			arrowChance = 0.1
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.58, posX, posY, floorNum, 0, 0.25, hexagonBreakable, "inner");
			break;
		case 40:
			tileType = hexagonUnbreakable;
			break;
		case 41:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.1
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.54, posX, posY, floorNum, 0, 0.31, hexagonUnbreakable, "half");
			break;
		case 42:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.4
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0.1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.51, posX, posY, floorNum, 0, 0.71, hexagonBreakable, "outer");
			break;
		case 43:
			crackedChance = 0
			trampolineChance = 0.004
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0.4
			tileType = perlinLevelGeneration(0.56, posX, posY, floorNum, 0, 0.30, hexagonIce, "inner");
			break;
		case 44:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.9
			wallChance = 0
			breakableChance = 0.4
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.60, posX, posY, floorNum, 0, 0.80, hexagonRandomFall, "half");
			break;
		case 45:
			tileType = hexagonUnbreakable;
			break;
		case 46:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 1
			wallChance = 0.2
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.57, posX, posY, floorNum, 0, 0.55, hexagonUnbreakable, "inner");
			break;
		case 47:
			crackedChance = 0.02
			trampolineChance = 0.008
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.63, posX, posY, floorNum, 0, 0.27, hexagonBreakable, "outer");
			break;
		case 48:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.29, posX, posY, floorNum, 0, 0.69, hexagonIce, "half");
			break;
		case 49:
			crackedChance = 0.01
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0.8
			fallChance = 1
			tileType = perlinLevelGeneration(0.66, posX, posY, floorNum, 0, 0.50, hexagonRandomFall, "inner");
			break;
		case 50:
			tileType = hexagonUnbreakable;
			break;
		case 51:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.25
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0.25
			tileType = perlinLevelGeneration(0.61, posX, posY, floorNum, 0, 0.43, hexagonUnbreakable, "outer");
			break;
		case 52:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0.2
			iceChance = 0
			fallChance = 0.2
			tileType = perlinLevelGeneration(0.64, posX, posY, floorNum, 0, 0.65, hexagonBreakable, "half");
			break;
		case 53:
			crackedChance = 0
			trampolineChance = 0.005
			arrowChance = 0.05
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.05
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.68, posX, posY, floorNum, 0, 0.08, hexagonIce, "inner");
			break;
		case 54:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.32, posX, posY, floorNum, 0, 0.13, hexagonBreakable, "half");
			break;
		case 55:
			tileType = hexagonUnbreakable;
			break;
		case 56:
			crackedChance = 0.015
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.70, posX, posY, floorNum, 0, 0.58, hexagonBreakable, "inner");
			break;
		case 57:
			crackedChance = 0.015
			trampolineChance = 0.003
			arrowChance = 0.05
			wallChance = 0.1
			breakableChance = 1
			unbreakableChance = 0.75
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.65, posX, posY, floorNum, 0, 0.48, hexagonBreakable, "outer");
			break;
		case 58:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.2
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.72, posX, posY, floorNum, 0, 0.29, hexagonIce, "inner");
			break;
		case 59:
			crackedChance = 0
			trampolineChance = 0.004
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.15
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.67, posX, posY, floorNum, 0, 0.04, hexagonRandomFall, "half");
			break;
		case 60:
			tileType = hexagonUnbreakable;
			break;
		case 61:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.5, posX, posY, floorNum, 0, 0.72, hexagonUnbreakable, "outer");
			break;
		case 62:
			crackedChance = 0.04
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.74, posX, posY, floorNum, 0, 0.47, hexagonBreakable, "inner");
			break;
		case 63:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.71, posX, posY, floorNum, 0, 0.52, hexagonIce, "half");
			break;
		case 64:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.1
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.35, posX, posY, floorNum, 0, 0.36, hexagonRandomFall, "inner");
			break;
		case 65:
			tileType = hexagonUnbreakable;
			break;
		case 66:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.2
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.73, posX, posY, floorNum, 0, 0.62, hexagonUnbreakable, "outer");
			break;
		case 67:
			crackedChance = 0.001
			trampolineChance = 0.003
			arrowChance = 0
			wallChance = 0.04
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0.2
			tileType = perlinLevelGeneration(0.77, posX, posY, floorNum, 0, 0.39, hexagonBreakable, "half");
			break;
		case 68:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.8
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.76, posX, posY, floorNum, 0, 0.19, hexagonIce, "inner");
			break;
		case 69:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.79, posX, posY, floorNum, 0, 0.68, hexagonRandomFall, "inner");
			break;
		case 70:
			tileType = hexagonUnbreakable;
			break;
		case 71:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 1.5
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.78, posX, posY, floorNum, 0, 0.14, hexagonUnbreakable, "half");
			break;
		case 72:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.41, posX, posY, floorNum, 0, 0.46, hexagonBreakable, "outer");
			break;
		case 73:
			crackedChance = 0
			trampolineChance = 0.005
			arrowChance = 0.1
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 1
			fallChance = 1
			tileType = perlinLevelGeneration(0.74, posX, posY, floorNum, 0, 0.22, hexagonIce, "inner");
			break;
		case 74:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.83, posX, posY, floorNum, 0, 0.56, hexagonRandomFall, "half");
			break;
		case 75:
			tileType = hexagonUnbreakable;
			break;
		case 76:
			crackedChance = 0.5
			trampolineChance = 0.01
			arrowChance = 0.75
			wallChance = 0.5
			breakableChance = 0.5
			unbreakableChance = 0.75
			iceChance = 0.2
			fallChance = 0.5
			tileType = perlinLevelGeneration(0.36, posX, posY, floorNum, 0, 0.24, hexagonUnbreakable, "inner");
			break;
		case 77:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.55, posX, posY, floorNum, 0, 0.60, hexagonBreakable, "outer");
			break;
		case 78:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.80, posX, posY, floorNum, 0, 0.75, hexagonIce, "inner");
			break;
		case 79:
			crackedChance = 0
			trampolineChance = 0.005
			arrowChance = 0
			wallChance = 0.01
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.87, posX, posY, floorNum, 0, 0.42, hexagonRandomFall, "half");
			break;
		case 80:
			tileType = hexagonUnbreakable;
			break;
		case 81:
			crackedChance = 0
			trampolineChance = 0.04
			arrowChance = 0.5
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.42, posX, posY, floorNum, 0, 0.31, hexagonBreakable, "outer");
			break;
		case 82:
			crackedChance = 0.05
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.2
			breakableChance = 1
			unbreakableChance = 0.4
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.54, posX, posY, floorNum, 0, 0.09, hexagonBreakable, "inner");
			break;
		case 83:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.1
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.68, posX, posY, floorNum, 0, 0.66, hexagonIce, "half");
			break;
		case 84:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.82, posX, posY, floorNum, 0, 0.85, hexagonRandomFall, "inner");
			break;
		case 85:
			tileType = hexagonUnbreakable;
			break;
		case 86:
			crackedChance = 0.05
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.1
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.43, posX, posY, floorNum, 0, 0.34, hexagonUnbreakable, "inner");
			break;
		case 87:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.2
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0.1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.69, posX, posY, floorNum, 0, 0.70, hexagonBreakable, "outer");
			break;
		case 88:
			crackedChance = 0
			trampolineChance = 0.005
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.77, posX, posY, floorNum, 0, 0.55, hexagonIce, "half");
			break;
		case 89:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0.8
			fallChance = 1
			tileType = perlinLevelGeneration(0.85, posX, posY, floorNum, 0, 0.23, hexagonRandomFall, "inner");
			break;
		case 90:
			tileType = hexagonUnbreakable;
			break;
		case 91:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.57, posX, posY, floorNum, 0, 0.03, hexagonUnbreakable, "outer");
			break;
		case 92:
			crackedChance = 0.07
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			iceChance = 0
			fallChance = 0
			tileType = perlinLevelGeneration(0.43, posX, posY, floorNum, 0, 0.77, hexagonBreakable, "inner");
			break;
		case 93:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.25
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.76, posX, posY, floorNum, 0, 0.58, hexagonIce, "half");
			break;
		case 94:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.82, posX, posY, floorNum, 0, 0.40, hexagonRandomFall, "inner");
			break;
		case 95:
			tileType = hexagonUnbreakable;
			break;
		case 96:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.6
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			iceChance = 0
			fallChance = 0.2
			tileType = perlinLevelGeneration(0.90, posX, posY, floorNum, 0, 0.53, hexagonUnbreakable, "half");
			break;
		case 97:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.1
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 1
			fallChance = 0
			tileType = perlinLevelGeneration(0.78, posX, posY, floorNum, 0, 0.65, hexagonIce, "outer");
			break;
		case 98:
			crackedChance = 0.01
			trampolineChance = 0.05
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			iceChance = 0
			fallChance = 1
			tileType = perlinLevelGeneration(0.85, posX, posY, floorNum, 0, 0.18, hexagonRandomFall, "inner");
			break;
		case 99:
			crackedChance = 0.1
			trampolineChance = 0.01
			arrowChance = 0.4
			wallChance = 0.2
			breakableChance = 0.5
			unbreakableChance = 0.5
			iceChance = 0.35
			fallChance = 0.35
			tileType = perlinLevelGeneration(0.90, posX, posY, floorNum, 0, 0.63, hexagonBreakable, "half");
			break;
		case 100:
			tileType = hexagonUnbreakable;
			break;	
	}

	return tileType;
}

// @desc difficulty is a value between 0 and 1, where 0 is easy and 1 is hard
// posX and posY are the coordinates of the tile
// floorNum is the current floor number
// seed is a random seed value
// frequency is a value between 0 and 1, where 0 is low frequency and 1 is high frequency
function perlinLevelGeneration(difficulty, posX, posY, floorNum, seed, frequency, baseLevelTile, generationType) {
	random_set_seed(floorNum + seed + posX + posY);

    var adjustedDifficulty = adjustDifficulty(difficulty);
    var adjustedFrequency = adjustFrequency(frequency);

    var noiseValue = perlin_noise((posX + seed) * adjustedFrequency, (posY + seed) * adjustedFrequency, floorNum * 321); // between -1 and 1, with normal distribution around 0

	generated = false
	if (generationType == "inner") {
		var adjustedFrequency = adjustFrequency(frequency);
		generated = noiseValue > 0 + ((adjustedDifficulty * 2) - 1)
	} else if (generationType == "outer") {
		generated = noiseValue <  0 - difficulty  * difficulty * difficulty || noiseValue > difficulty * difficulty * difficulty
	} else if (generationType == "half") {
		generated = noiseValue > -1 + adjustedDifficulty * 2
	}

    if (generated) {
        // Calculate total chance for enabled tile types
        var totalChance = crackedChance + trampolineChance + arrowChance + wallChance + breakableChance + unbreakableChance + iceChance + fallChance;

        // Generate a random number between 0 and the total chance
		var randomChoice = random(totalChance);
        var cumulativeChance = 0;

        // Select the tile type based on cumulative chances
        cumulativeChance += crackedChance;
        if (randomChoice < cumulativeChance) return hexagonDeadly;

        cumulativeChance += trampolineChance;
        if (randomChoice < cumulativeChance) return hexagonJump

        cumulativeChance += arrowChance;
        if (randomChoice < cumulativeChance) return hexagonArrow;

        cumulativeChance += wallChance;
        if (randomChoice < cumulativeChance) return hexagonWall;

        cumulativeChance += breakableChance;
        if (randomChoice < cumulativeChance) return hexagonBreakable;

        cumulativeChance += unbreakableChance;
        if (randomChoice < cumulativeChance) return hexagonUnbreakable;

        cumulativeChance += iceChance;
        if (randomChoice < cumulativeChance) return hexagonIce;

        cumulativeChance += fallChance;
        if (randomChoice < cumulativeChance) return hexagonRandomFall;

        // Default tile if none selected
        return baseLevelTile;
    } else {
        return noone;
    }
}


// @desc difficulty is a value between 0 and 1, where 0 is easy and 1 is hard
// posX and posY are the coordinates of the tile
// floorNum is the current floor number
// seed is a random seed value
function randomLevelGeneration(difficulty, posX, posY, floorNum, seed, baseLevelTile) {
    random_set_seed(floorNum + seed + posX + posY);

    // Generate a random number between 0 and 1
    var noiseValue = random(1);

    if (noiseValue > difficulty) {
        // Calculate total chance for enabled tile types
        var totalChance = crackedChance + trampolineChance + arrowChance + wallChance + breakableChance + unbreakableChance + iceChance + fallChance;

        // Generate a random number between 0 and the total chance
        var randomChoice = random(totalChance);
        var cumulativeChance = 0;

        // Select the tile type based on cumulative chances
        cumulativeChance += crackedChance;
        if (randomChoice < cumulativeChance) return hexagonDeadly;

        cumulativeChance += trampolineChance;
        if (randomChoice < cumulativeChance) return hexagonJump;

        cumulativeChance += arrowChance;
        if (randomChoice < cumulativeChance) return hexagonArrow;

        cumulativeChance += wallChance;
        if (randomChoice < cumulativeChance) return hexagonWall;

        cumulativeChance += breakableChance;
        if (randomChoice < cumulativeChance) return hexagonBreakable;

        cumulativeChance += unbreakableChance;
        if (randomChoice < cumulativeChance) return hexagonUnbreakable;

        cumulativeChance += iceChance;
        if (randomChoice < cumulativeChance) return hexagonIce;

        cumulativeChance += fallChance;
        if (randomChoice < cumulativeChance) return hexagonRandomFall;

        // Default tile if none selected
        return baseLevelTile;
    } else {
        return noone;
    }
}

function adjustDifficulty(difficulty) {

	k = 0.5

    // Ensure k is a positive number to avoid division by zero and incorrect results
    if (k <= 0) {
        k = 1; // default to 1 if an invalid value is provided
    }

    // Apply the custom sigmoid-like function with steepness factor k
    var adjustedDifficulty = power(difficulty, k) / (power(difficulty, k) + power(1 - difficulty, k));
    return adjustedDifficulty;
}

function adjustFrequency(frequency) {
    return lerp(0.008, 0.025, frequency);
}

function destroyTileLayer(floorNum) {
    with (objParentHexagon) { 
        if (floorNumber > floorNum) {
            instance_destroy();
        }
    }
}
