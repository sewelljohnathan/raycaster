
int WORLD_SIZE = 24;
float DIAGONAL_WORLD_SIZE = WORLD_SIZE*sqrt(2);

int MINIMAP_SIZE = 100;

void renderMiniMap()
{
  
    /* Map */
    float rectSize = MINIMAP_SIZE / WORLD_SIZE;
    for (int y = 0; y < WORLD_SIZE; y++)
    {
        for (int x = 0; x < WORLD_SIZE; x++)
        {
            if (!isEmptySpace(x, y))
            {
                stroke(0);
                fill(0);
            }
            else
            {
                stroke(255);
                fill(255);
            }
            rect(x*rectSize, y*rectSize, rectSize, rectSize);
        }
    }
    
    /* Rays */
    float dtheta = (float) FOV / width;
    for (int rayNum = 0; rayNum < width; rayNum++)
    {
        float theta = -FOV/2 + rayNum*dtheta + playerTheta;
        if (theta < 0) theta += 360;
        theta %= 360;
        Ray ray = castRay(theta);

        stroke(255, 0, 0);
        strokeWeight(1);
        line(rectSize*playerX, rectSize*playerY, rectSize*ray.x, rectSize*ray.y);
    }
    
    /* Player Triangle */
    stroke(0, 0, 0);
    fill(0, 255, 0);
    pushMatrix();
    translate(rectSize * playerX, rectSize * playerY);
    rotate(radians(playerTheta));
    triangle(5, 0, -2, 5, -2, -5);
    popMatrix();
    
    /* Shadow */
    for (int y = 0; y < MINIMAP_SIZE; y++)
    {
        for (int x = 0; x < MINIMAP_SIZE; x++)
        {
            float mapX = x * (WORLD_SIZE / MINIMAP_SIZE);
            float mapY = y * (WORLD_SIZE / MINIMAP_SIZE);
            float dist = sqrt(pow(playerX - mapX, 2) + pow(playerY - mapY, 2));
        }
    }

}
