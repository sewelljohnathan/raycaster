
class Ray
{
    float x, y;
    float distance;
    int collisionSide;
    
    Ray(float x, float y, int collisionSide)
    {
        this.x = x;
        this.y = y;
        this.distance = distance(playerX, playerY, x, y);
        this.collisionSide = collisionSide;
    }
}

Ray castRay(float theta)
{
    
    float curX = 0;
    float curY = 0;
    float y_offset = 0;
    float x_offset = 0;
    int dof = 0;
    
    /* Horizontal Interception */
    float horzFinalX = 0, horzFinalY = 0, horzDistance = DIAGONAL_WORLD_SIZE;
    if (theta > 180) 
    {
        curY = floor(playerY) - 0.0001;
        curX = (playerY - curY) * (-1/tan(radians(theta))) + playerX;
        y_offset = -1;
        x_offset = -y_offset * (-1/tan(radians(theta)));
    }
    if (theta < 180) 
    {
        curY = floor(playerY)+1;
        curX = (playerY - curY) * (-1/tan(radians(theta))) + playerX;
        y_offset = 1;
        x_offset = -y_offset * (-1/tan(radians(theta)));
    }
    if (theta != 0 && theta != 180)
    {
        dof = 0;
        while (dof < DIAGONAL_WORLD_SIZE)
        {
        if (isInBounds(curX, curY) && !isEmptySpace(curX, curY))
        {
            horzFinalX = curX;
            horzFinalY = curY;
            horzDistance = distance(playerX, playerY, curX, curY);
            break;
        }
        else
        {
            curX += x_offset;
            curY += y_offset;
            dof++;
        }
        }
        
    }
    
    /* Vertical Interception */
    float vertFinalX = 0, vertFinalY = 0, vertDistance = DIAGONAL_WORLD_SIZE;
    if (theta > 90 && theta < 270) 
    {
        curX = floor(playerX) - 0.0001;
        curY = (playerX - curX) * (-tan(radians(theta))) + playerY;
        x_offset = -1;
        y_offset = -x_offset * (-tan(radians(theta)));
    }
    if (theta < 90 || theta > 270)
    {
        curX = floor(playerX)+1;
        curY = (playerX - curX) * (-tan(radians(theta))) + playerY;
        x_offset = 1;
        y_offset = -x_offset * (-tan(radians(theta)));
    }
    
    if (theta != 90 && theta != 270)
    {
        dof = 0;
        while (dof < DIAGONAL_WORLD_SIZE)
        {
        if (isInBounds(curX, curY) && !isEmptySpace(curX, curY))
        {
            vertFinalX = curX;
            vertFinalY = curY;
            vertDistance = distance(playerX, playerY, curX, curY);  
            break;
        }
        else
        {
            curX += x_offset;
            curY += y_offset;
            dof++;
        }
        }
        
    }
    
    /* Comparison */
    if (horzDistance < vertDistance) return new Ray(horzFinalX, horzFinalY, 1);
    else                             return new Ray(vertFinalX, vertFinalY, 0);
    
}
