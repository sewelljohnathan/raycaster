
void renderMain()
{
    float dtheta = (float) FOV / width;
    int texX, texY;
    for (int rayNum = 0; rayNum < width; rayNum++)
    {
        
        /* Get Ray */
        float theta = -FOV/2 + rayNum*dtheta + playerTheta;
        if (theta < 0) theta += 360;
        theta %= 360;
        Ray ray = castRay(theta);  
        
        float lineHeight = (1 * height / (ray.distance * cos(radians(theta - playerTheta)))); 
        int lineStart = (int) (height/2 - lineHeight/2);
        int lineEnd = (int) (height/2 + lineHeight/2);
        
        
        /* Walls */
        float wallX;
        if (ray.collisionSide == 1) wallX = ray.x;
        else                        wallX = ray.y;
        wallX -= floor(wallX);

        texX = floor(wallX * TEXTURE_SIZE);
        if (ray.collisionSide == 0 && (playerTheta < 90 || playerTheta > 270)) texX = TEXTURE_SIZE - texX - 1;
        if (ray.collisionSide == 1 && (playerTheta > 180 && playerTheta < 360)) texX = TEXTURE_SIZE - texX - 1;
        
        // ternary operators used because even with the check that y is within bounds, lineHeight can be large enough that this loop slows the game
        for (int y = (lineStart<0?0:lineStart); y < (lineEnd>height?height:lineEnd); y++)
        {
            if (y < 0 || y >= height) continue;
            texY = floor(((y - lineStart) / lineHeight) * TEXTURE_SIZE);
            
            //int wallColor = TEXTURES[(ray.collisionType - 1)][texY][texX];
            int wallColor = WALLS.get(floor(ray.x)*32+texX, floor(ray.y)*32+texY);
            wallColor = shadowColor(wallColor, ray.distance * cos(radians(theta - playerTheta))); 
            pixels[rayNum + y*width] = wallColor;
        }
        
        
        /* Floors / Ceiling */
        float floorWallX, floorWallY;
        if (ray.collisionSide == 0 && (theta < 90 || theta > 270))
        {
            floorWallX = floor(ray.x);
            floorWallY = floor(ray.y) + wallX;
        }
        else if (ray.collisionSide == 0 && (theta > 90 && theta < 270))
        {
            floorWallX = floor(ray.x) + 1;
            floorWallY = floor(ray.y) + wallX;
        }
        else if (ray.collisionSide == 1 && (theta < 180))
        {
            floorWallX = floor(ray.x) + wallX;
            floorWallY = floor(ray.y);
        }
        else
        {
            floorWallX = floor(ray.x) + wallX;
            floorWallY = floor(ray.y) + 1;
        }
        
        float distWall, currentDist;
        distWall = ray.distance * cos(radians(theta - playerTheta));
        
        for (int y = lineEnd; y < height; y++)
        {
            currentDist = height / (2.0 * y - height);
            float weight = currentDist / distWall;
            float currentFloorX = weight * floorWallX + (1.0 - weight) * playerX;
            float currentFloorY = weight * floorWallY + (1.0 - weight) * playerY;
            
            texX = floor((currentFloorX - floor(currentFloorX)) * TEXTURE_SIZE);
            texY = floor((currentFloorY - floor(currentFloorY)) * TEXTURE_SIZE);
            
            if (floor(currentFloorY) >= WORLD_SIZE || floor(currentFloorX) >= WORLD_SIZE || floor(currentFloorY) < 0 || floor(currentFloorX) < 0) continue; // Magic. Sometimes the indices are out of range and idk why
            
            int floorColor = FLOOR.get(floor(currentFloorX)*32+texX, floor(currentFloorY)*32+texY);
            floorColor = shadowColor(floorColor, currentDist);
            
            pixels[rayNum + y*width]            = floorColor;
            pixels[rayNum + (height-y-1)*width] = floorColor;
        }

    }
    
}
